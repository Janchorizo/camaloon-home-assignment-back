## camaloon-home-assignment-back

[![RSpec test workbench](https://github.com/Janchorizo/camaloon-home-assignment-back/actions/workflows/rspec.yml/badge.svg)](https://github.com/Janchorizo/camaloon-home-assignment-back/actions/workflows/rspec.yml)

Repository for the API server implemented for the job application at
[Camaloon](https://camaloon.com/).

It is a Ruby server with [Ruby on Rails](https://rubyonrails.org/) as the framework,
and transpiled using Webpack.

### Using the app
#### Locally
_Ruby, Ruby on Rails and a working installation of PostgreSQL are required._
> The server expects a local database setup with: `user=local_user`, `password=local_user` and
> `database=camaloon_local`. Ensure your installation fits this or change
> the default configuration in `config/database.yml`.

Clone the repo into the desired work directory:

`git clone git@github.com:Janchorizo/camaloon-home-assignment-back.git`

Install the dependencies:

`make install`

Execute the tests:

`make test`

Run the development server with `make serve`.

#### Online
The app is being deployed using [Netlify](https://www.netlify.com/) from the
master branch. You can access it at [https://camaloon-home-assignment.netlify.app/](https://camaloon-home-assignment.netlify.app/).

### Collaborating
If you want to collaborate in the project, feel free to clone the repo and create
a pull request. Github will show a link to the deployed test environment so you
can checkout the result.

I will look through the code and decide if it should be integrated :)
