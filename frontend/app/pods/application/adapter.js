import JSONAPIAdapter from 'ember-data/adapters/json-api';
import DataAdapterMixin from '../../mixins/data-adapter-mixin';

export default JSONAPIAdapter.extend(DataAdapterMixin, {
  namespace: 'api/v1',
  authorizer: 'authorizer:devise',
});
