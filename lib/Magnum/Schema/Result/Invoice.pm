use utf8;
package Magnum::Schema::Result::Invoice;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Magnum::Schema::Result::Invoice

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

=head1 TABLE: C<invoice>

=cut

__PACKAGE__->table("invoice");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 date

  data_type: 'date'
  datetime_undef_if_invalid: 1
  default_value: '0000-00-00'
  is_nullable: 0

=head2 customer

  data_type: 'integer'
  default_value: 0
  is_foreign_key: 1
  is_nullable: 0

=head2 contract

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 cust_ref

  data_type: 'varchar'
  is_nullable: 1
  size: 20

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "date",
  {
    data_type => "date",
    datetime_undef_if_invalid => 1,
    default_value => "0000-00-00",
    is_nullable => 0,
  },
  "customer",
  {
    data_type      => "integer",
    default_value  => 0,
    is_foreign_key => 1,
    is_nullable    => 0,
  },
  "contract",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "cust_ref",
  { data_type => "varchar", is_nullable => 1, size => 20 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 contract

Type: belongs_to

Related object: L<Magnum::Schema::Result::Contract>

=cut

__PACKAGE__->belongs_to(
  "contract",
  "Magnum::Schema::Result::Contract",
  { id => "contract" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "RESTRICT",
    on_update     => "RESTRICT",
  },
);

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

=head2 invoice_lines

Type: has_many

Related object: L<Magnum::Schema::Result::InvoiceLine>

=cut

__PACKAGE__->has_many(
  "invoice_lines",
  "Magnum::Schema::Result::InvoiceLine",
  { "foreign.invoice" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07042 @ 2015-07-28 21:49:55
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:67pAV5Dbt5MjEJqWeB4b3A


# You can replace this text with custom code or comments, and it will be preserved on regeneration

sub vat_rate {
  my $self = shift;

  my $type = shift || 'standard';

  my $vat_rs = $self->result_source->schema->resultset('VatRate');

  return $vat_rs->vat_rate_for_date($self->date)->rate;
}

sub vat_lines {
  my $self = shift;

  return $self->invoice_lines->filter_standard_vat;
}

sub has_vat_lines {
  my $self = shift;

  return $self->vat_lines->count;
}

sub zerovat_lines {
  my $self = shift;

  return $self->invoice_lines->filter_zero_vat;
}

sub has_zerovat_lines {
  my $self = shift;

  return $self->zerovat_lines->count;
}

sub vatexempt_lines {
  my $self = shift;

  return $self->invoice_lines->filter_exempt_vat;
}

sub has_vatexempt_lines {
  my $self = shift;

  return $self->vatexempt_lines->count;
}

sub vat_total {
  my $self = shift;

  my $tot = 0;
  foreach ($self->vat_lines) {
    $tot += $_->amount;
  }

  return $tot;
}

sub zerovat_total {
  my $self = shift;

  my $tot = 0;
  foreach ($self->zerovat_lines) {
    $tot += $_->amount;
  }

  return $tot;
}

sub vatexempt_total {
  my $self = shift;

  my $tot = 0;
  foreach ($self->vatexempt_lines) {
    $tot += $_->amount;
  }

  return $tot;
}

sub vat {
  my $self = shift;

  return $self->vat_total * $self->vat_rate / 100;
}

sub grand_total {
  my $self = shift;

  return $self->vat_total + $self->vat + $self->zerovat_total +
         $self->vatexempt_total;
}

sub filename {
  my $self = shift;

  return sprintf('inv%05d', $self->id);
}

1;


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
