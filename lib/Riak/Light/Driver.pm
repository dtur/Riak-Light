## no critic (RequireUseStrict, RequireUseWarnings)
package Riak::Light::Driver;
## use critic

use English qw( -no_match_vars );
use Riak::Light::Connector;
use Moo;
use Types::Standard -types;

# ABSTRACT: Riak Driver, deal with the binary protocol

has connector => ( is => 'ro', required => 1 );

sub BUILDARGS {
    my ( undef, %args ) = @_;

    if ( exists $args{socket} ) {
        my $connector = Riak::Light::Connector->new( socket => $args{socket} );

        $args{connector} = $connector;
    }

    +{%args};
}

sub perform_request {
    my ( $self, %request ) = @_;

    my $request_body = $request{body};
    my $request_code = $request{code};

    my $message = pack( 'c a*', $request_code, $request_body );

    $self->connector->perform_request($message);
}

sub read_response {
    my ($self)   = @_;
    my $response = $self->connector->read_response()
      or return $self->_parse_error();
    $self->_parse_response($response);
}

sub _parse_response {
    my ( $self, $response ) = @_;
    my ( $code, $body ) = unpack( 'c a*', $response );

    { code => $code, body => $body, error => undef };
}

sub _parse_error {
    { code => -1, body => undef, error => $ERRNO || "Socket Closed" };
}

1;

__END__

=head1 DESCRIPTION
  
  Internal class
