use utf8;
package Magnum::Schema::Result::Customer;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Magnum::Schema::Result::Customer

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

=head1 TABLE: C<customer>

=cut

__PACKAGE__->table("customer");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 name

  data_type: 'varchar'
  default_value: (empty string)
  is_nullable: 0
  size: 50

=head2 address

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 contact_name

  data_type: 'varchar'
  is_nullable: 1
  size: 50

=head2 phone

  data_type: 'varchar'
  is_nullable: 1
  size: 50

=head2 fax

  data_type: 'varchar'
  is_nullable: 1
  size: 50

=head2 mobile

  data_type: 'varchar'
  is_nullable: 1
  size: 50

=head2 email

  data_type: 'varchar'
  is_nullable: 1
  size: 50

=head2 invoice_name

  data_type: 'varchar'
  is_nullable: 1
  size: 50

=head2 invoice_address

  data_type: 'varchar'
  default_value: (empty string)
  is_nullable: 0
  size: 255

=head2 note

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "name",
  { data_type => "varchar", default_value => "", is_nullable => 0, size => 50 },
  "address",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "contact_name",
  { data_type => "varchar", is_nullable => 1, size => 50 },
  "phone",
  { data_type => "varchar", is_nullable => 1, size => 50 },
  "fax",
  { data_type => "varchar", is_nullable => 1, size => 50 },
  "mobile",
  { data_type => "varchar", is_nullable => 1, size => 50 },
  "email",
  { data_type => "varchar", is_nullable => 1, size => 50 },
  "invoice_name",
  { data_type => "varchar", is_nullable => 1, size => 50 },
  "invoice_address",
  { data_type => "varchar", default_value => "", is_nullable => 0, size => 255 },
  "note",
  { data_type => "varchar", is_nullable => 1, size => 255 },
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
  { "foreign.customer" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 invoices

Type: has_many

Related object: L<Magnum::Schema::Result::Invoice>

=cut

__PACKAGE__->has_many(
  "invoices",
  "Magnum::Schema::Result::Invoice",
  { "foreign.customer" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07042 @ 2015-07-28 21:49:55
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:/F4OBDAa8OtnXthJQBXDJA


# You can replace this text with custom code or comments, and it will be preserved on regeneration

sub name_addr {
  my $self = shift;
  my @name_addr;

  foreach (qw(invoice_name name invoice_address)) {
    push @name_addr, split /\n/, $self->$_ if $self->$_;
  }

  return 'Unknown' unless @name_addr;

  return \@name_addr;
}

1;


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
