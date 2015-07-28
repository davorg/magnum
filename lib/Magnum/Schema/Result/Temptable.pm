use utf8;
package Magnum::Schema::Result::Temptable;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Magnum::Schema::Result::Temptable

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

=head1 TABLE: C<temptable>

=cut

__PACKAGE__->table("temptable");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  default_value: 0
  is_nullable: 0

=head2 invoice

  data_type: 'integer'
  default_value: 0
  is_nullable: 0

=head2 line_no

  data_type: 'integer'
  default_value: 0
  is_nullable: 0

=head2 week

  data_type: 'integer'
  is_nullable: 1

=head2 description

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 amount

  data_type: 'decimal'
  default_value: 0.00
  is_nullable: 0
  size: [10,2]

=head2 vat

  data_type: 'char'
  default_value: 'standard'
  is_nullable: 0
  size: 10

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", default_value => 0, is_nullable => 0 },
  "invoice",
  { data_type => "integer", default_value => 0, is_nullable => 0 },
  "line_no",
  { data_type => "integer", default_value => 0, is_nullable => 0 },
  "week",
  { data_type => "integer", is_nullable => 1 },
  "description",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "amount",
  {
    data_type => "decimal",
    default_value => "0.00",
    is_nullable => 0,
    size => [10, 2],
  },
  "vat",
  {
    data_type => "char",
    default_value => "standard",
    is_nullable => 0,
    size => 10,
  },
);


# Created by DBIx::Class::Schema::Loader v0.07025 @ 2013-02-04 11:16:24
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:aRC7FtONunHrVXi0mjBiig


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
