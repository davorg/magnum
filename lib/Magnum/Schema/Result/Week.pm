use utf8;
package Magnum::Schema::Result::Week;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Magnum::Schema::Result::Week

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

=head1 TABLE: C<week>

=cut

__PACKAGE__->table("week");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 contract

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 start

  data_type: 'date'
  datetime_undef_if_invalid: 1
  default_value: '0000-00-00'
  is_nullable: 0

=head2 invoiced

  data_type: 'tinyint'
  is_nullable: 1

=head2 month

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "contract",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "start",
  {
    data_type => "date",
    datetime_undef_if_invalid => 1,
    default_value => "0000-00-00",
    is_nullable => 0,
  },
  "invoiced",
  { data_type => "tinyint", is_nullable => 1 },
  "month",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
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
  { is_deferrable => 1, on_delete => "RESTRICT", on_update => "RESTRICT" },
);

=head2 days

Type: has_many

Related object: L<Magnum::Schema::Result::Day>

=cut

__PACKAGE__->has_many(
  "days",
  "Magnum::Schema::Result::Day",
  { "foreign.week" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 invoice_lines

Type: has_many

Related object: L<Magnum::Schema::Result::InvoiceLine>

=cut

__PACKAGE__->has_many(
  "invoice_lines",
  "Magnum::Schema::Result::InvoiceLine",
  { "foreign.week" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 month

Type: belongs_to

Related object: L<Magnum::Schema::Result::Month>

=cut

__PACKAGE__->belongs_to(
  "month",
  "Magnum::Schema::Result::Month",
  { id => "month" },
  { is_deferrable => 1, on_delete => "RESTRICT", on_update => "RESTRICT" },
);


# Created by DBIx::Class::Schema::Loader v0.07046 @ 2017-02-18 11:42:17
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:h15Nso1A9QRFk9H+6n1NGw

sub is_in_month {
  my $self = shift;
  my ($year, $month) = @_;

  foreach ($self->days) {
    return 1 if $_->is_in_month($year, $month);
  }

  return;
}

sub units {
  my $self = shift;

  my $total = 0;
  $total += $_->units for $self->days;

  return $total;
}

sub get_day {
  my $self = shift;
  my ($day) = @_;
  
  foreach ($self->days) {
    return $_ if $_->day_date->day_name eq $day;
  }

  return;
}

# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
