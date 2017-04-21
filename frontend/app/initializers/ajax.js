export function initialize(application) {
  application.inject('controller:register', 'ajax', 'service:ajax');
}

export default {
  name: 'ajax',
  initialize
};
