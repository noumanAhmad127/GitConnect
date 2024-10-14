// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails";
import "controllers";
// app/javascript/packs/application.js
import "./add_jquery";
import "jquery"; 
import "cocoon"; 

//= require rails-ujs

import Rails from "@rails/ujs";
Rails.start();

// import Rails from "@rails/ujs";
// Rails.start();

$(document)
  .on("ajax:success", ".like-button-form", function (e) {
    const [data, status, xhr] = e.detail;
    $("#like-btn-" + data.id).html(data.html);
    $("#like-count-" + data.id).text(data.like_count);
  })
  .on("ajax:error", function (e) {
    alert("Error!");
  });

$.ajaxSetup({ cache: false });




