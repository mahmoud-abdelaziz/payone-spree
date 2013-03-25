# Spree PAYONE (Paymentgateway)

Add support for PAYONE payment methods and gateway as a payment methods.

## Installation

#### 1. Add the following to your Gemfile

```bash
gem 'spree_payone', :git => 'git://github.com/PAYONE/spree.git' 
```

#### 2. Run 

```bash
$ bundle install
```

#### 3. To copy and apply migrations, inject JavaScript and CSS includes run: 

```bash
$ rails g spree_payone:install
```

## Configuring

After the installation visit 'PAYONE Documentation' under the 'Configuration' tab.

## Dependencies

* [Spree](https://github.com/spree/spree) (spree_core 1.2.x)
