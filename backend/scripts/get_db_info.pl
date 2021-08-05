use strict;
use warnings;

use Zonemaster::Backend::Config;

my $config = Zonemaster::Backend::Config->load_config();
my $dbtype = $config->DB_engine;

my $obj = bless {}, $dbtype;

# TODO: use the port method in new release
if ( $obj->isa("MySQL") ) {
    print $config->MYSQL_host . ":3306" # . $config->MYSQL_port;
} elsif ( $obj->isa("PostgreSQL") ) {
    print $config->POSTGRESQL_host . ":5432" ; # . $config->POSTGRESQL_port;
}
