use utf8;
package Magnum::Schema::Result::Employee;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Magnum::Schema::Result::Employee

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 COMPONENTS LOADED

=over 4

=item * L<DBIx::Class::InflateColumn::DateTime>

=back

=cut

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 TABLE: C<employee>

=cut

__PACKAGE__->table("employee");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 first_name

  data_type: 'varchar'
  default_value: (empty string)
  is_nullable: 0
  size: 50

=head2 last_name

  data_type: 'varchar'
  default_value: (empty string)
  is_nullable: 0
  size: 50

=head2 title

  data_type: 'varchar'
  is_nullable: 1
  size: 50

=head2 email

  data_type: 'varchar'
  is_nullable: 1
  size: 50

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "first_name",
  { data_type => "varchar", default_value => "", is_nullable => 0, size => 50 },
  "last_name",
  { data_type => "varchar", default_value => "", is_nullable => 0, size => 50 },
  "title",
  { data_type => "varchar", is_nullable => 1, size => 50 },
  "email",
  { data_type => "varchar", is_nullable => 1, size => 50 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 contracts

Type: has_many

Related object: L<Magnum::Schema::Result::Contract>

=cut

__PACKAGE__->has_many(
  "contracts",
  "Magnum::Schema::Result::Contract",
  { "foreign.employee" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07025 @ 2013-02-04 11:16:24
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:gITY7vxHAuz3xbPkkvVvog

sub name {
  my $self = shift;
  return $self->first_name . ' ' . $self->last_name;
}


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
