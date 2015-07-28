use utf8;
package Magnum::Schema::Result::Contract;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Magnum::Schema::Result::Contract

=cut

use strict;
use warnings;

use Moose;
use MooseX::NonMoose;
use MooseX::MarkAsMethods autoclean => 1;
extends 'DBIx::Class::Core';

=head1 COMPONENTS LOADED

=over 4

=item * L<DBIx::Class::InflateColumn::DateTime>

=back

=cut

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 TABLE: C<contract>

=cut

__PACKAGE__->table("contract");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 customer

  data_type: 'integer'
  default_value: 0
  is_foreign_key: 1
  is_nullable: 0

=head2 site

  data_type: 'integer'
  default_value: 0
  is_foreign_key: 1
  is_nullable: 0

=head2 start

  data_type: 'date'
  datetime_undef_if_invalid: 1
  default_value: '0000-00-00'
  is_nullable: 0

=head2 end

  data_type: 'date'
  datetime_undef_if_invalid: 1
  is_nullable: 1

=head2 rate

  data_type: 'decimal'
  default_value: 0.00
  is_nullable: 0
  size: [10,2]

=head2 rate_unit

  data_type: 'char'
  default_value: (empty string)
  is_nullable: 0
  size: 10

=head2 hour_per_unit

  data_type: 'decimal'
  default_value: 0.00
  is_nullable: 0
  size: [10,2]

=head2 min_billed_units

  data_type: 'decimal'
  default_value: 0.00
  is_nullable: 0
  size: [10,2]

=head2 employee

  data_type: 'integer'
  default_value: 0
  is_foreign_key: 1
  is_nullable: 0

=head2 product

  data_type: 'integer'
  default_value: 0
  is_foreign_key: 1
  is_nullable: 0

=head2 cust_ref

  data_type: 'varchar'
  is_nullable: 1
  size: 200

=head2 cust_ref_desc

  data_type: 'varchar'
  is_nullable: 1
  size: 40

=head2 cust_contact

  data_type: 'varchar'
  is_nullable: 1
  size: 40

=head2 cust_contact_desc

  data_type: 'varchar'
  is_nullable: 1
  size: 40

=head2 disp_cust_contact

  data_type: 'char'
  default_value: 'N'
  is_nullable: 0
  size: 1

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "customer",
  {
    data_type      => "integer",
    default_value  => 0,
    is_foreign_key => 1,
    is_nullable    => 0,
  },
  "site",
  {
    data_type      => "integer",
    default_value  => 0,
    is_foreign_key => 1,
    is_nullable    => 0,
  },
  "start",
  {
    data_type => "date",
    datetime_undef_if_invalid => 1,
    default_value => "0000-00-00",
    is_nullable => 0,
  },
  "end",
  { data_type => "date", datetime_undef_if_invalid => 1, is_nullable => 1 },
  "rate",
  {
    data_type => "decimal",
    default_value => "0.00",
    is_nullable => 0,
    size => [10, 2],
  },
  "rate_unit",
  { data_type => "char", default_value => "", is_nullable => 0, size => 10 },
  "hour_per_unit",
  {
    data_type => "decimal",
    default_value => "0.00",
    is_nullable => 0,
    size => [10, 2],
  },
  "min_billed_units",
  {
    data_type => "decimal",
    default_value => "0.00",
    is_nullable => 0,
    size => [10, 2],
  },
  "employee",
  {
    data_type      => "integer",
    default_value  => 0,
    is_foreign_key => 1,
    is_nullable    => 0,
  },
  "product",
  {
    data_type      => "integer",
    default_value  => 0,
    is_foreign_key => 1,
    is_nullable    => 0,
  },
  "cust_ref",
  { data_type => "varchar", is_nullable => 1, size => 200 },
  "cust_ref_desc",
  { data_type => "varchar", is_nullable => 1, size => 40 },
  "cust_contact",
  { data_type => "varchar", is_nullable => 1, size => 40 },
  "cust_contact_desc",
  { data_type => "varchar", is_nullable => 1, size => 40 },
  "disp_cust_contact",
  { data_type => "char", default_value => "N", is_nullable => 0, size => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 customer

Type: belongs_to

Related object: L<Magnum::Schema::Result::Customer>

=cut

__PACKAGE__->belongs_to(
  "customer",
  "Magnum::Schema::Result::Customer",
  { id => "customer" },
  { is_deferrable => 1, on_delete => "RESTRICT", on_update => "RESTRICT" },
);

=head2 employee

Type: belongs_to

Related object: L<Magnum::Schema::Result::Employee>

=cut

__PACKAGE__->belongs_to(
  "employee",
  "Magnum::Schema::Result::Employee",
  { id => "employee" },
  { is_deferrable => 1, on_delete => "RESTRICT", on_update => "RESTRICT" },
);

=head2 invoices

Type: has_many

Related object: L<Magnum::Schema::Result::Invoice>

=cut

__PACKAGE__->has_many(
  "invoices",
  "Magnum::Schema::Result::Invoice",
  { "foreign.contract" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 product

Type: belongs_to

Related object: L<Magnum::Schema::Result::Product>

=cut

__PACKAGE__->belongs_to(
  "product",
  "Magnum::Schema::Result::Product",
  { id => "product" },
  { is_deferrable => 1, on_delete => "RESTRICT", on_update => "RESTRICT" },
);

=head2 site

Type: belongs_to

Related object: L<Magnum::Schema::Result::Site>

=cut

__PACKAGE__->belongs_to(
  "site",
  "Magnum::Schema::Result::Site",
  { id => "site" },
  { is_deferrable => 1, on_delete => "RESTRICT", on_update => "RESTRICT" },
);

=head2 weeks

Type: has_many

Related object: L<Magnum::Schema::Result::Week>

=cut

__PACKAGE__->has_many(
  "weeks",
  "Magnum::Schema::Result::Week",
  { "foreign.contract" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07042 @ 2015-07-28 21:49:54
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:NdcPbPLZmeJRoJFsaqGWHA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
