# Bio-Oil Distributor Ordering System

A web-based ordering system that allows distributors to place orders for Bio-Oil products and enables Union Swiss administrators to configure distributors and their pricing.

## Setup Instructions

- **Ruby/Rails version**: Ruby 3.3.6 / Rails 8.0.1
- **Dependencies**: Run `bundle install` and `yarn install`
- **Database**: Run `bin/rails db:prepare` (creates, migrates, and seeds)
- **Environment**: Ensure logic for `Admin` console access is configured in development.

## How to Run

1. Navigate to the `bio-oil-web-app` directory:

   ```run in wsl(ubuntu)
   cd bio-oil-web-app
   ```

2. Start the application:

   ```run in wsl(ubuntu)
   rails server
   ```

3. Access the application at [http://127.0.0.1:3000](http://127.0.0.1:3000).

*Use `Ctrl + C` to stop the application.*

## Useful Commands

### Server & General

- `rails server`: Starts the local development server.
- `Ctrl + C`: Stops the running server.

### CSS & Styling

- `npm run build:css`: Compiles SCSS files and applies vendor prefixing. Run this if/when style changes aren't appearing.
- `npm run watch:css`: Automatically rebuilds CSS whenever a `.scss` file is saved.

### Database Management

- `rails db:migrate`: Applies pending database schema changes.
- `rails db:seed`: Loads initial data (Admin/Distributor accounts).
- `rails db:reset`: Wipes the database and starts fresh (drop -> create -> migrate -> seed).
- `rails db:migrate:status`: Verifies which migrations have been applied.

## Login Credentials (Test Accounts)

### Admin

- **Username**: `admin@unionswiss.com`
- **Password**: `headOffice1234`

- **Username**: `craig@unionswiss.com`
- **Password**: `Letsinnovate1234`

### Distributor

- **Username**: `distributor_sa@example.com`
- **Password**: `distr0SA1234`

- **Username**: `distributor_uk@example.com`
- **Password**: `distr0UK1234`

## Project Status & Roadmap

### Key Features Implemented

- [x] Premium Authentication UI (Glassmorphism & Branded photography)
- [x] Secure Login/Password recovery (Paranoid Mode enabled)
- [x] Admin-led User & Distributor creation
- [x] Role-based access control (Admin vs. Distributor)
