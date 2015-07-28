use utf8;
package Magnum::Schema::Result::Day;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Magnum::Schema::Result::Day

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

=head1 TABLE: C<day>

=cut

__PACKAGE__->table("day");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 week

  data_type: 'integer'
  default_value: 0
  is_foreign_key: 1
  is_nullable: 0

=head2 day_date

  data_type: 'date'
  datetime_undef_if_invalid: 1
  default_value: '0000-00-00'
  is_nullable: 0

=head2 start

  data_type: 'time'
  default_value: '00:00:00'
  is_nullable: 0

=head2 end

  data_type: 'time'
  default_value: '00:00:00'
  is_nullable: 0

=head2 lunch_start

  data_type: 'time'
  is_nullable: 1

=head2 lunch_end

  data_type: 'time'
  is_nullable: 1

=head2 other_breaks

  data_type: 'time'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "week",
  {
    data_type      => "integer",
    default_value  => 0,
    is_foreign_key => 1,
    is_nullable    => 0,
  },
  "day_date",
  {
    data_type => "date",
    datetime_undef_if_invalid => 1,
    default_value => "0000-00-00",
    is_nullable => 0,
  },
  "start",
  { data_type => "time", default_value => "00:00:00", is_nullable => 0 },
  "end",
  { data_type => "time", default_value => "00:00:00", is_nullable => 0 },
  "lunch_start",
  { data_type => "time", is_nullable => 1 },
  "lunch_end",
  { data_type => "time", is_nullable => 1 },
  "other_breaks",
  { data_type => "time", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 week

Type: belongs_to

Related object: L<Magnum::Schema::Result::Week>

=cut

__PACKAGE__->belongs_to(
  "week",
  "Magnum::Schema::Result::Week",
  { id => "week" },
  { is_deferrable => 1, on_delete => "RESTRICT", on_update => "RESTRICT" },
);


# Created by DBIx::Class::Schema::Loader v0.07042 @ 2015-07-28 21:49:55
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:ZK4fhYqluW7IDYVAxb4saw


# You can replace this text with custom code or comments, and it will be preserved on regeneration

use DateTime::Format::Strptime;
use DateTime::Duration;

my $date_p = DateTime::Format::Strptime->new(pattern => '%Y-%m-%d %H:%M:%S');

sub day_duration {
  my $self = shift;

  my $today = $self->day_date->ymd;

  my $start   = $date_p->parse_datetime("$today " . $self->start);

  die "Can't parse start (", $self->start, ") on $today\n"
    unless defined $start;

  my $end;
  if ($self->end eq '24:00:00') {
    $end = $date_p->parse_datetime("$today 23:59:59");
    $end->add(seconds => 1);
  } else {
    $end     = $date_p->parse_datetime("$today " . $self->end);
  }

  die "Can't parse end (", $self->end, ") on $today\n"
    unless defined $end;

  return $end - $start;
}

sub lunch_duration {
  my $self = shift;

  my $today = $self->day_date->ymd;

  my $l_start = $date_p->parse_datetime("$today " . $self->lunch_start);
  my $l_end   = $date_p->parse_datetime("$today " . $self->lunch_end);

  return $l_end - $l_start;
}

sub duration {
  my $self = shift;

  return $self->day_duration - $self->lunch_duration;
}

sub hours {
  my $self = shift;

  my $dur = $self->duration;

  return $dur->hours + ($dur->minutes / 60);
}

sub units {
  my $self = shift;

  my $hour_per_unit = $self->week->contract->hour_per_unit;
  return $self->hours / $hour_per_unit;
}

sub is_weekend {
  my $self = shift;

  return 1 if $self->day_date->day_name eq 'Saturday';
  return 1 if $self->day_date->day_name eq 'Sunday';
  return;
}

sub is_in_month {
  my $self = shift;
  my ($year, $month) = @_;

  return 1 if $self->day_date->year == $year
    and $self->day_date->month == $month;
  return;
}

1;


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
