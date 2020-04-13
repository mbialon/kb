# Cron

## Fields

`* * * * *`

- minute: 0-59
- hour: 0-23
- day of month: 1-31
- month: 1-12 (or names)
- day of week: 0-7 (0 or 7 is Sunday)

## Examples

| Case             | Cron           |
| ---------------- | -------------- |
| every 10 seconds | `*/10 * * * *` |
| every 12 hours   | `0 */12 * * *` |
| every 7 days     | `0 0 * * 0`    |

## Links

- [https://crontab.guru](https://crontab.guru)
