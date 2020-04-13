# Perl

## Modules and procs

http://en.wikipedia.org/wiki/Perl_module

*Foo.pm*

```
package Foo;

use strict;
use warnings;

our $VERSION = '1.00';

use base 'Exporter';

our @EXPORT = qw{hello bye};

sub hello {
  return 'Hello World!';
}

sub bye {
  my $name = $_[0];
  return "Bye, $name";
}

1;
```

*test.pl*

```
use Foo;

print &hello;
print &bye('John');
```
