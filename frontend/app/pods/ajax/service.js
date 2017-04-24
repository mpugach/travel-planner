import Ember from 'ember';
import AjaxService from 'ember-ajax/services/ajax';
import DataAdapterMixin from '../../mixins/data-adapter-mixin';

const {
  get,
  computed,
  getProperties,
  computed: {
    alias,
  },
  inject: {
    service,
  },
} = Ember;

export default AjaxService.extend(DataAdapterMixin, {
  namespace: '/api/v1',

  session: service(),

  auth: alias('session.data.authenticated'),

  headers: computed(
    'session.data.authenticated.uid',
    'session.data.authenticated.client',
    'session.data.authenticated.expiry',
    'session.data.authenticated.tokenType',
    'session.data.authenticated.accessToken',
    function() {
      const auth = getProperties(
        get(this, 'session.data.authenticated'),
        'uid',
        'client',
        'expiry',
        'tokenType',
        'accessToken'
      );

      return {
        'uid': auth.uid,
        'client': auth.client,
        'expiry': auth.expiry,
        'token-type': auth.tokenType,
        'access-token': auth.accessToken,
      };
    }
  ),
});
