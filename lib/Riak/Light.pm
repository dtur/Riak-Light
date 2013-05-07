## no critic (RequireUseStrict, RequireUseWarnings)
package Riak::Light;
## use critic

use Riak::Light::PBC;
use Riak::Light::Driver;
#use v5.12.0;
use JSON;
use Scalar::Util qw(blessed);
use Carp;
use Params::Validate qw(validate_pos);
use Moo;
use MooX::Types::MooseLike::Base qw(:all);

# ABSTRACT: Fast and lightweight Perl client for Riak

has port    => ( is => 'ro', isa => Int,  required => 1 );
has host    => ( is => 'ro', isa => Str,  required => 1 );
has timeout => ( is => 'ro', isa => Num,  default  => sub { 0.5 } );
#has autodie => ( is => 'ro', isa => Bool, default  => sub {   1 } );
has r       => ( is => 'ro', isa => Int,  default  => sub {   2 } );
has w       => ( is => 'ro', isa => Int,  default  => sub {   2 } );
has rw      => ( is => 'ro', isa => Int,  default  => sub {   2 } );

has driver  => ( is => 'lazy' );

sub _build_driver {
  my $self = shift;
  Riak::Light::Driver->new(
    port    => $self->port, 
    host    => $self->host, 
    timeout => $self->timeout
  )
}

sub BUILD {
  (shift)->driver
}

sub get {
  my ($self, $bucket, $key) = validate_pos(@_,1,1,1);
  
  $self->_parse_fetch_response(
    $self->_perform_fetch_request($bucket, $key)
  );
}

sub put {
  my ($self, $bucket, $key, $value, $content_type) = validate_pos(@_, 1,1,1,1, { default => 'application/json'});
 
  my $encoded_value = ($content_type eq 'application/json') 
    ? encode_json($value) 
    : $value;
  
  $self->_parse_store_response(
    $self->_perform_store_request($bucket, $key, $content_type, $encoded_value)
  );
}

sub del {
  my ($self, $bucket, $key) = validate_pos(@_,1,1,1);
  
  $self->_parse_delete_response(
    $self->_perform_delete_request($bucket, $key)
  );
}

sub ping {
  my $self = shift;
  $self->_parse_ping_response(
    $self->_perform_ping_request()
  )
}

sub _perform_ping_request {
  my $self = shift;
  $self->driver->perform_request(code => 1, body => q())
}

sub _parse_ping_response {
  my ($self, $response) = @_;
  $self->_parse_response(
    expected_code => 2,    
    response => $response
  );
}

sub _perform_fetch_request {
  my ($self, $bucket, $key) = @_;
   
  my $body = RpbGetReq->encode({ 
      r => $self->r,
      key => $key,
      bucket => $bucket
    });
    
  $self->driver->perform_request(code => 9, body => $body)
}

sub _parse_fetch_response {
  my ($self, $response) = @_;
  $self->_parse_response(
    expected_code => 10,    
    response => $response
  );
}

sub _perform_store_request{
  my ($self, $bucket, $key, $content_type, $encoded_value) = @_;
  
  my $body = RpbPutReq->encode({ 
       key => $key,
       bucket => $bucket,    
       content => {
         value => $encoded_value,
         content_type => $content_type,
      },
    });
  $self->driver->perform_request(code => 11, body => $body);
}

sub _parse_store_response {
  my ($self, $response) = @_;
  $self->_parse_response(
    expected_code => 12,    
    response => $response
  );
}

sub _perform_delete_request {
  my ($self, $bucket, $key) = @_;
    
  my $body = RpbDelReq->encode({ 
     key => $key,
     bucket => $bucket,
     dw => $self->rw
   });

 $self->driver->perform_request(code => 13, body => $body);
}

sub _parse_delete_response {
  my ($self, $response) = @_;
  $self->_parse_response(
    expected_code => 14,    
    response => $response
  );
}

sub _parse_response {
  my ($self, %args)  = @_;
  my $response       = $args{response};
  my $expected_code  = $args{expected_code};
    
  my $response_code  = $response->{code} //  -1;
  my $response_body  = $response->{body} // q();
  my $response_error = $response->{error};  
  
  # return internal error message
  return $self->_process_generic_error($response_error) 
    if defined $response_error;
  
  # return default message
  return $self->_process_generic_error("Unexpected Response Code (got: $response_code, expected: $expected_code)") 
    if $response_code != $expected_code and $response_code != 0;
  
  # return the error msg
  return $self->_process_riak_error($response_body) 
    if $response_code == 0;
    
  # return the result from fetch  
  return $self->_process_riak_fetch($response_body)
    if $response_code == $expected_code and $response_code == 10;
    
  1  # return true value, in case of a successful put/del 
}

sub _process_riak_fetch {
  my ($self, $encoded_message) = @_;
  
  my $decoded_message = RpbGetResp->decode($encoded_message);
  
  if(  $decoded_message 
    and blessed $decoded_message
    and defined $decoded_message->content
    and defined $decoded_message->content->[0]){
  
    my $value        = $decoded_message->content->[0]->value;
    my $content_type = $decoded_message->content->[0]->content_type;
    
    return ($content_type eq 'application/json') ? decode_json($value) : $value    
  }
  
  undef
}

sub _process_riak_error {
  my ($self, $encoded_message) = @_;
  
  my $decoded_message = RpbErrorResp->decode($encoded_message);
  
  $self->_process_error($decoded_message->errmsg);
}

sub _process_generic_error {
  my ($self, $error) = @_;
    
  confess $error
}

1;

=head1 NAME

  Riak::Light - Fast and lightweight Perl client for Riak

=head1 SYNOPSIS

  # create a new instance - using pbc only
  my $client = Riak::Light->new(
    host => '127.0.0.1',
    port => 8087
  );

  $client->ping() or die "ops, riak is not alive";

  # store hashref into bucket 'foo', key 'bar'
  $client->put( foo => bar => { baz => 1024 }, content_type => 'application/json')

  # fetch hashref from bucket 'foo', key 'bar'
  my $hash = $client->get( foo => 'bar');

  # delete hashref from bucket 'foo', key 'bar'
  $client->del(foo => 'bar');