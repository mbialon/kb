# MongoDB

## Update a property

```
db.user.update({'login': 'john@example.com'}, {$set: {active: true}});
```

## Authentication

```
db.auth(username, password)
```

## Backup and restore

https://docs.mongodb.org/manual/tutorial/backup-and-restore-tools/

### Backup

```
mongodump --collection foobar --db test --out /data/backup/
```

### Restore

```
mongorestore --username guest --password secret --db test /data/backup/foobar.bson
```

## Create index

https://docs.mongodb.org/manual/tutorial/create-a-compound-index/

## Set top-level fields

```
db.products.update(
  { _id: 100 },
  { $set: { quantity: 500 } }
)
```

## Query operators

- https://docs.mongodb.com/manual/reference/operator/query/

```
db.collection.find( { age: { $eq: 42 } } )
```

### Operators

- `$eq`
- `$gt`
- `$gte`
- `$lt`
- `$lte`
- `$ne`
- `$in`
- `$nin`

## Sorting

- https://docs.mongodb.com/manual/reference/method/cursor.sort/#cursor.sort

```
db.collection.find().sort( { age: 1 } )
```

### Order

- ascending: 1
- descending: -1
