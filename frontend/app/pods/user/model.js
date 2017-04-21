import attr from 'ember-data/attr';
import Model from 'ember-data/model';
import EmberCpValidations from 'ember-cp-validations';

const { validator, buildValidations } = EmberCpValidations;

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

export default Model.extend(Validations, {
  email: attr('string'),
});
