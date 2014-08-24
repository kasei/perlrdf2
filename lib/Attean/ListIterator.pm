use v5.14;
use warnings;

=head1 NAME

Attean::ListIterator - Iterator implementation backed by a list/array of values

=head1 VERSION

This document describes Attean::ListIterator version 0.001

=head1 SYNOPSIS

  use v5.14;
  use Attean;
  my @values = map { Attean::Literal->new($_) } (1,2,3);
  my $iter = Attean::ListIterator->new(
    values => \@values,
    item_type => Moose::Meta::TypeConstraint::Role->new(role => 'Attean::API::Term'),
  );
  
  say $iter->next->value; # 1
  say $iter->next->value; # 2
  say $iter->next->value; # 3

=head1 DESCRIPTION

The Attean::ListIterator class represents a typed iterator.
It conforms to the L<Attean::API::RepeatableIterator|Attean::API::Iterator> role.

The Attean::ListIterator constructor requires two named arguments:

=over 4

=item values

An array reference containing the items to iterate over.

=item item_type

A L<Moose::Meta::TypeConstraint> object representing the type of the items
that will be returned from the iterator

=back

=head1 METHODS

=over 4

=cut

package Attean::ListIterator 0.001 {
	use Moo;
	use MooX::Types::MooseLike::Base qw(ArrayRef Int);
	
	with 'Attean::API::RepeatableIterator';
	
	has values => (is => 'ro', isa => ArrayRef, required => 1);
	has current => (is => 'rw', isa => Int, init_arg => undef, default => 0);
	
	sub BUILD {
		my $self	 = shift;
		if (1) {
			# type check the list values
			my $constraint	= $self->item_type;
			foreach my $item (@{ $self->values }) {
				$constraint->assert_valid($item);
			}
		}
	}
	
=item C<< reset >>

Resets the iterator's internal state so that iteration begins again at the
beginning of the values array.

=cut

	sub reset {
		my $self	= shift;
		$self->current(0);
	}
	
=item C<< next >>

Returns the iterator's next item, or undef upon reaching the end of iteration.

=cut

	sub next {
		my $self	= shift;
		my $list	= $self->values;
		my $index	= $self->current;
		my $item	= $list->[$index];
		return unless defined($item);
		$self->current(1+$index);
		return $item;
	}

	no Moose;
	__PACKAGE__->meta->make_immutable;
}

1;

__END__

=back

=head1 BUGS

Please report any bugs or feature requests to through the GitHub web interface
at L<https://github.com/kasei/attean/issues>.

=head1 SEE ALSO

L<http://www.perlrdf.org/>

=head1 AUTHOR

Gregory Todd Williams  C<< <gwilliams@cpan.org> >>

=head1 COPYRIGHT

Copyright (c) 2014 Gregory Todd Williams.
This program is free software; you can redistribute it and/or modify it under
the same terms as Perl itself.

=cut
