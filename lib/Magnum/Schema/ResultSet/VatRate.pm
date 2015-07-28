package Magnum::Schema::ResultSet::VatRate;

use strict;
use warnings;
use base 'DBIx::Class::ResultSet';

sub vat_rate_for_date {
  my $self = shift;
  my ($date, $type) = @_;

  $type //= 'standard';

  my $dtf = $self->result_source->schema->storage->datetime_parser;
  my $search_date = $dtf->format_datetime($date);

  my ($rate) = $self->search({
    type => $type,
    start_date => [ { '<=' => $search_date },
                    undef ],
    end_date   => [ { '>=' => $search_date },
                    undef ],
  });

  return $rate;
}

1;
