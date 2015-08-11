{% extends "base.md" %}

{% block article %}

# Some notation

Here we start with some basic syntax that we will use throughout this site.
Alice wants to send a message to Bob.

* $$m$$: The plaintext, unencrypted message
* $$k$$: The secret key that both Alice and Bob have agreed to use to encrypt and
  decrypt the messages they exchange.
* $$c$$: The encrypted message, or ciphertext.
* $$c = Enc_k(m)$$: The encryption function that encrypts plaintext $$m$$ with
  secret key $k$ to produce ciphertext $$c$$.
* $$m = Dec_k(c)$$: The decryption function that decrypts ciphertext $$c$$ with
  secret key $$k$$ to produce plaintext $$m$$.

<!-- TODO diagram -->

A *cryptosystem* is defined by its $$Enc_k(\cdot)$$ and $$Dec_k(\cdot)$$ functions.
It is also defined by its $$Gen$$ function, which defines how keys are generated.
The correctness property of a cryptosystem is satisfied if
$$Dec_k(Enc_k(m)) = m$$.

{% endblock %}
