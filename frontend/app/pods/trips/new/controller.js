import Ember from 'ember';
import ModelEditable from '../../../mixins/model-editable';

const {
  Controller,
} = Ember;

export default Controller.extend(ModelEditable, {
  successMessage: 'The trip is saved!',
  routeAfterSave: 'index',
});
