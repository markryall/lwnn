# language without a nice name

This is just an experiment to see what I can come up with as far as a concatenative language.

Refer to the features for the details and behaviour of the language so far.

The key goals are:

- minimal syntax (so far only . and integers have any particularly significant meaning - everything else is a just symbol that may be used as the key to a binding)
- very simple but flexible scoping model
- easily introspected runtime data structures (just a stack and a bindings hash)