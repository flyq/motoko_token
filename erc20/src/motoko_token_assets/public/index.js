import motoko_token from 'ic:canisters/motoko_token';

motoko_token.greet(window.prompt("Enter your name:")).then(greeting => {
  window.alert(greeting);
});
