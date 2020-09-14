# Login.gov partners app

Use the [`Makefile`](makefile) to run common commands.

## Testing

The app will look for the [login.gov IdP](https://github.com/18F/identity-idp) running locally at `http://localhost:3000`

Run `make setup` before `make run`

Log in with `admin@gsa.gov`. See [seeds.rb](db/seeds.rb) for more accounts and data to test with.
