import Ember from 'ember';
import DestroyConfirmable from '../../../mixins/destroy-confirmable';

const {
  Controller,
  inject: {
    service,
  },
} = Ember;

export default Controller.extend(DestroyConfirmable, {
  currentUser: service(),
});
