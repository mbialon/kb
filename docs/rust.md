# Rust

## Statements and expressions

```
let x = 4;

let y = {
    let x = 1;
    x + 2
};

let z = if {} else {};

let q = loop { break 42 };
```

### Tuples

```
let tup = (1, 2.0, "foo");
let (x, y, s) = tup;
```

### Arrays

```
let a = [1, 2, 3, 4];
```

```
let b = [2; 3]; // same as let b = [2, 2, 2];
```

## Loops

```
loop {}
```

```
while true {}
```

```
for i in (1..10) {}
```

## Functions

```
fn foo(x: i32, y: f64) -> u128 {}
```
