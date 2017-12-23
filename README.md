# Coinmon

[![Gem Version](https://badge.fury.io/rb/coinmon.svg)](https://badge.fury.io/rb/coinmon)

## Abstract

A dead-simple utility to monitor your crypto-currency portfolio.

## Usage

The tool expects your portfolio to be in the YAML format, like so:

```
:btc:
  :name: Bitcoin
  :amount: 2
  :investment: 600
:bch:
  :name: Bitcoin Cash
  :amount: 1.63
  :investment: 500
```

Make sure you set all investment fields in one single currency (Eg if you bought different cryptos using different currencies, you'll have to normalize everything into the same currency).

Then, you can call the tool like so:

```bash
coinmon path/to/portfolio.yml GBP
```

It will automatically make the math and give you a summary.

It automatically gets rates from:

- http://coincap.io for the crypto-currencies.
- https://api.fixer.io for the fiat currencies.

That's because the cypto-currency rates are in USD, if you're asking for GBP it has to perform an intermediate conversion.
