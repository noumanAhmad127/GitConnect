// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails";
import "controllers";
// app/javascript/packs/application.js
import "./add_jquery";
import "jquery"; // Importing jQuery from the Import Map
import "cocoon"; // Importing Cocoon from the Import Map

import Rails from "@rails/ujs";
Rails.start();

// import Rails from "@rails/ujs";
// Rails.start();
