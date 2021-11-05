# CoinForBarter SDK

CoinForBarter Flutter SDK.

## Getting Started

This SDK allows you to recieve payments in cryptocurrency for your projects.

Follow these simple steps to start

1. Visit www.coinforbarter.com to get started by creating an account.

2. Go to the API section of the dashboard and get your _public keys_ [test keys for testing]

3. Import the CoinForBarter SDK and follow the code example.

> **IMPORTANT:**
>
> To use CoinForBarter SDK, you must use `GetMaterialApp` instead of just `MaterialApp` at the start of your entire project.
>
> This is because CoinForBarter SDK depends on contextless state management and depends on the [GetX_package](https://pub.dev/packages/get).
>
> This however doesn't disturb any start managment package that you are using.
