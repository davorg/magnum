use utf8;
package Magnum::Schema;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Schema';

__PACKAGE__->load_namespaces;


# Created by DBIx::Class::Schema::Loader v0.07025 @ 2013-02-04 11:16:24
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:6axCrvoJv1rtVOw/wPhpNQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration

sub get_schema {
  my @errs;

  foreach (qw[MAG_DB MAG_DB_USER MAG_DB_PASS MAG_DB_HOST]) {
    push @errs, $_ unless defined $ENV{$_};
  }
  if (@errs) {
    die "You need to set the following environment variables: @errs\n";
  }

  my $sch = Magnum::Schema->connect(
    "dbi:mysql:database=$ENV{MAG_DB};host=$ENV{MAG_DB_HOST}",
    $ENV{MAG_DB_USER}, $ENV{MAG_DB_PASS},
    { mysql_enable_utf8 => 1 }
  );

  return $sch;
}

1;
