import attr from 'ember-data/attr';
import Ember from 'ember';
import Model from 'ember-data/model';
import EmberCpValidations from 'ember-cp-validations';

const {
  validator,
  buildValidations,
} = EmberCpValidations;

const Validations = buildValidations({
  password: [
    validator('length', {
      min: 8,
    })
  ],
  passwordConfirmation: [
    validator('confirmation', {
      on: 'password',
      message: '{description} do not match',
      description: 'Passwords',
    })
  ]
});

const {
  computed: {
    mapBy,
  },
} = Ember;

export default Model.extend(Validations, {
  role: attr('string'),
  email: attr('string'),
  canManageUsers: attr('boolean'),
  permittedRolesToSet: attr(),

  emailErrors: mapBy('errors.email', 'message'),
});
