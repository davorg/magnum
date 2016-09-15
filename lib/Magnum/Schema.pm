use utf8;
package Magnum::Schema;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use Moose;
use MooseX::MarkAsMethods autoclean => 1;
extends 'DBIx::Class::Schema';

__PACKAGE__->load_namespaces;


# Created by DBIx::Class::Schema::Loader v0.07042 @ 2015-07-28 21:49:54
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:foK58VqUDGvMqg44iil8Yw


# You can replace this text with custom code or comments, and it will be preserved on regeneration

sub get_schema {
  my @errs;

  foreach (qw[MAG_DB MAG_DB_USER MAG_DB_PASS MAG_DB_HOST]) {
    push @errs, $_ unless defined $ENV{$_};
  }
  if (@errs) {
    die "You need to set the following environment variables: @errs\n";
  }

  return __PACKAGE__->connect(
    "dbi:mysql:database=$ENV{MAG_DB};host=$ENV{MAG_DB_HOST}",
    $ENV{MAG_DB_USER}, $ENV{MAG_DB_PASS},
    { mysql_enable_utf8 => 1 }
  );
}

1;


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable(inline_constructor => 0);
1;
