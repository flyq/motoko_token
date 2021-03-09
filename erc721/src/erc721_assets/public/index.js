import erc721 from 'ic:canisters/erc721';

erc721.greet(window.prompt("Enter your name:")).then(greeting => {
  window.alert(greeting);
});
