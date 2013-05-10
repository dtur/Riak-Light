BEGIN {
    unless ( $ENV{RIAK_PBC_HOST} ) {
        require Test::More;
        Test::More::plan(
            skip_all => 'variable RIAK_PBC_HOST is not defined' );
    }
}

use Test::More tests => 2;
use Test::Exception;
use Riak::Light;
use JSON;

subtest "simple get/set/delete test" => sub {
    plan tests => 10;

    my ( $host, $port ) = split ':', $ENV{RIAK_PBC_HOST};

    my $client = Riak::Light->new( host => $host, port => $port );

    my $scalar = '3.14159';
    my $hash = { baz => 1024 };

    ok( $client->ping(),     "should can ping" );
    ok( $client->is_alive(), "should can ping" );
    ok( $client->put( foo => "bar", $hash ),
        "should store the hashref in Riak"
    );
    is_deeply(
        $client->get( foo => 'bar' ), $hash,
        "should fetch the stored hashref from Riak"
    );

    ok( $client->put_raw( foo => "bar2", $scalar ),
        "should store the raw scalar in Riak"
    );
    is( $client->get_raw( foo => 'bar2' ), $scalar,
        "should fetch the raw scalar from Riak"
    );

    ok( $client->del( foo => 'bar' ), "should delete the hashref" );
    ok( !$client->get( foo => 'bar' ), "should fetch UNDEF from Riak" );

    ok( $client->put( foo => "baz", 'TEXT', 'plain/text' ),
        "should store the text in Riak"
    );
    is( $client->get( foo => "baz" ), 'TEXT',,
        "should fetch the text from Riak"
    );

    #ok(!$@, "should has no error - foo => bar is undefined");
};

subtest "sequence of 1024 get/set" => sub {
    plan tests => 1024;

    my ( $host, $port ) = split ':', $ENV{RIAK_PBC_HOST};

    my $client = Riak::Light->new( host => $host, port => $port );

    my $hash = {
        foo       => bar  => baz     => 123,
        something => very => complex => [ 1, 2, 3, 4, 5 ]
    };

    my ( $bucket, $key );
    for ( 1 .. 1024 ) {
        ( $bucket, $key ) =
          ( "bucket" . int( rand(1024) ), "key" . int( rand(1024) ) );

        $hash->{random} = int( rand(1024) );

        $client->put( $bucket => $key => $hash );

        my $got_complex_structure = $client->get( $bucket => $key );
        is_deeply(
            $got_complex_structure, $hash,
            "get($bucket=>$key)should got the same structure"
        );
    }
};
