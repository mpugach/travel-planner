import Ember from 'ember';
import AjaxService from 'ember-ajax/services/ajax';

const {
  computed,
  getProperties,
  computed: {
    alias,
  },
} = Ember;

export default AjaxService.extend({
  namespace: '/api/v1',

  auth: alias('session.data.authenticated'),

  headers: computed('auth.uid', 'auth.client', 'auth.expiry', 'auth.tokenType', 'auth.accessToken', function() {
    const {
      uid,
      client,
      expiry,
      tokenType,
      accessToken,
    } = getProperties(this, 'uid', 'client', 'expiry', 'tokenType', 'accessToken');

    return {
      'uid': uid,
      'client': client,
      'expiry': expiry,
      'token-type': tokenType,
      'access-token': accessToken,
    };
  }),
});
