import Ember from 'ember';
import config from './config/environment';

const Router = Ember.Router.extend({
  location: config.locationType,
  rootURL: config.rootURL
});

Router.map(function() {
  this.route('login');
  this.route('profile');
  this.route('password');
  this.route('register');

  this.route('users', function() {
    this.route('edit', { path: '/:id/edit' });
    this.route('new');
    this.route('trips', { path: '/:userId/trips' });
  });

  this.route('trips', function() {
    this.route('new');
    this.route('edit', { path: '/:id/edit' });
  });
});

export default Router;
