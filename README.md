## - Description of the problem and solution.
Problem: email campaigns delivery (proxy) service. Implemented backend for UI from task technical description. Service handles calls to external Mail delivery providers in background worker.

## - How to run the solution locally (no need to set up a live server or infrastructure).
```bash
git clone https://github.com/pandwoter/emails_api
cd emails_api
bundle 
bundle exec rails s
```

## - Reasoning behind your technical choices, including architectural.
There is a simple provider rotation algorithm ```delivery/email_delivery_service.rb``` (we try to call each available provider sequentially, if we fail, we just go to another one). To scale horizontally with new providers we simply need to follow some conventions: 1) add ```mailers/providers/<provider_name>/base_mailer.rb``` which defines ```delivery_method``` and error interceptor for a particular adapter library 2) add provider name in ```def enabled_providers``` in ```delivery/email_delivery_service.rb``` (this method is added for convenience (in case we don't want to include all providers from mailers folder in rotation)). Also, there is no business logic in controllers (I used services to encapsulate it). Each service returns Result monad (this is huge advantage for future tests). Also, I used dependencies injection in service constructors to achieve painless testing in isolation

## - Trade-offs you might have made, anything you left out, or what you might do differently if you were to spend additional time on the project.
Actually we can tune up rotation algorithm to handle each request to a particular provider in thread (we can consider thread pool implementation) or asynchronously (async-http or any actor pattern implementation). Also, I had some problems with Mail providers API (because I haven't any own domain nor time to properly test and dive into possible Mail services drawbacks). As an improvement we can store all delivery attempts and results in separate table (for now we just keep this in ```delivery_state``` field of the ```campaigns``` table and schedule retry if all services in rotation pool are down)
