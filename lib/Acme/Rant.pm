package Acme::Rant;
use strict;
$^W = 1;

use vars qw[$VERSION @EXPORT $PUNC $CURSE $VOID $RANT];
$VERSION = (qw$Revision: 0.1$)[1];
@EXPORT  = qw[vent];
$PUNC    = quotemeta q[!@#\$%^&*_?];
$CURSE   = qr/
              (?:
                 (?:
                    (?:what|why|who|where|when|how)
                    \s+
                 )?
                 the\s+)?      # possible prefix
                 [$PUNC]{3,}   # frustrated cursing
                 (?:-[\w]+)?   # possible suffix
                 (?:\s*,)?     # possible comma
             /xi;
$VOID    = qr/
              (?:my|our|use|sub|local)[\s(]+$ # keywords
             /x;
$RANT    = '';

use base qw[Exporter];

use Filter::Simple sub {
    s/RANT/\$Acme::Rant::RANT = q/;
    s<$CURSE>
     <$` =~ /$VOID/ ? '' : 'vent'>ge;
};

sub vent {
    my ($data) = @_;

    return defined($data) || 1;
}

1;

__END__

=pod

=head1 NAME

Acme::Rant - Extends Perl's Ability to Let You Rant

=head1 SYNOPSIS

    use Acme::Rant;

    my (@#%@-ing @list) = qw[foo];

    print the $#@%-ing @list, "\n";

    if ( $list[0] eq 'foo' ) {
        !*%^-you() and @#%-me ;
    }

    if ( @list < 2 ) {
        die what the @#$%, RANT {
            What the heck do you think you're doing?!
        };
    }

=head1 DESCRIPTION

C<Acme::Rant> implements an infinite (well, C<max(N)> for very
large values of C<N>) number of functions that are exported by
default.  Each of these functions give you a unique ability to
vent Acme::Rant over your code.

=head2 Parameters

If the function is called with parameters, those parameters
will be returned in a list.  If your function was called with
zero parameters, it will return true.  Remember that these are
functions and may require parenthesis to disambiguate meaning
and context.

=head2 Context

Context is a bit different for these venting functions.  Void
context refers to an instance when your frustrations should not
do anything, most often when venting just after keywords like
C<my>, C<use>, C<sub>, and so on.  Other contexts work as described
in L</Parameters>.

=head2 Syntax

The core functions are named with the following list of characters.

    !@#\$%^&*_?

The core function name may have a suffix of any alpha characters,
denoted by a leading dash (C<->).

    #@$%-it

There are a number of possibilities for prefixing the core function
name.  First is the word C<the> which may itself be prefixed by one
of the six questions C<who>, C<what>, C<when>, C<why>, C<how>, and
C<where>.

    the #@$%?
    what the %@#$
    why the &^%@-ing $dog

The possible combinations are most certainly not endless, but it will
take a while to get there.

=head2 Ranting

You may go futher off the deep end by ranting at will.  It is an
excellent form of documentation.

    RANT {
        So, you decided it would be a good idea to return undef
        from your method call and make me lookup a package
        variable to get the data?!  You so stupid!
    }

=head1 THANKS

Like so many modules, this has been inspired by Damian Conway. Not only
inspired, but concieved, thunk up, all but written by Damian Conway.

    what the #!@$, RANT {
        SO THANKS A LOT DAMIAN!
    };

=head1 AUTHOR

Casey West, <F<casey@geeknest.com>>

=head1 COPYRIGHT

Copyright (c) 2003 Casey West <casey@geeknest.com>.  All
rights reserved.  This program is free software; you can
redistribute it and/or modify it under the same terms as
Perl itself.

=cut
