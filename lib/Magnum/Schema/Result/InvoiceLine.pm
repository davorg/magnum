use utf8;
package Magnum::Schema::Result::InvoiceLine;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Magnum::Schema::Result::InvoiceLine

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

=head1 TABLE: C<invoice_line>

=cut

__PACKAGE__->table("invoice_line");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 invoice

  data_type: 'integer'
  default_value: 0
  is_foreign_key: 1
  is_nullable: 0

=head2 line_no

  data_type: 'integer'
  default_value: 0
  is_nullable: 0

=head2 week

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 description

  data_type: 'varchar'
  default_value: (empty string)
  is_nullable: 0
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
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "invoice",
  {
    data_type      => "integer",
    default_value  => 0,
    is_foreign_key => 1,
    is_nullable    => 0,
  },
  "line_no",
  { data_type => "integer", default_value => 0, is_nullable => 0 },
  "week",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "description",
  { data_type => "varchar", default_value => "", is_nullable => 0, size => 255 },
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

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 UNIQUE CONSTRAINTS

=head2 C<alt_key>

=over 4

=item * L</invoice>

=item * L</line_no>

=back

=cut

__PACKAGE__->add_unique_constraint("alt_key", ["invoice", "line_no"]);

=head1 RELATIONS

=head2 invoice

Type: belongs_to

Related object: L<Magnum::Schema::Result::Invoice>

=cut

__PACKAGE__->belongs_to(
  "invoice",
  "Magnum::Schema::Result::Invoice",
  { id => "invoice" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 week

Type: belongs_to

Related object: L<Magnum::Schema::Result::Week>

=cut

__PACKAGE__->belongs_to(
  "week",
  "Magnum::Schema::Result::Week",
  { id => "week" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "CASCADE",
  },
);


# Created by DBIx::Class::Schema::Loader v0.07025 @ 2013-02-04 11:21:57
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:fjgEiBWK/FXMsrcF1vulIg


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
