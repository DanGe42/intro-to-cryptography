# Introduction to Cryptography

> Cryptography (or cryptology; from Greek κρυπτός kryptós, "hidden, secret";
> and γράφειν graphein, "writing", or -λογία -logia, "study", respectively) is
> the practice and study of techniques for secure communication in the presence
> of third parties (called adversaries).
-- [Wikipedia entry on cryptography](http://en.wikipedia.org/wiki/Cryptography)

Cryptography has many applications in day-to-day life, from keeping your
[Internet communications
secret](http://en.wikipedia.org/wiki/Transport_Layer_Security) to securing the
[credit card transactions](http://en.wikipedia.org/wiki/EMV) you make at
a physical store. It serves as the foundation of many systems that perform
authentication and keep data secure.

Cryptography is an interdisciplinary topic. It is a crucial part of security but
is not all of it. It is a fun application of mathematics (much of public key
cryptography relies on number theory) and a fun application of theoretical
computer science.

This website is intended to be an extended introduction to applied
cryptography. While a strong background in mathematics, in particular number
theory and probability, will be helpful, it is not required as we will cover
much of the necessary mathematics. An introductory background in computer
science (knowing about P and NP) will be assumed.

## A brief summary of cryptography

> But I don't have time to read this entire site!
-- You (but hopefully not)

If you just want a quick reference:

* Never implement your own crypto.
* Don't use insecure PRNGs like `rand()`, `srand()`, `java.util.Random`. Use
[these instead](http://en.wikipedia.org/wiki/Cryptographically_secure_pseudorandom_number_generator)
* Don't use
[ECB](http://en.wikipedia.org/wiki/Block_cipher_mode_of_operation#Electronic_codebook_.28ECB.29)
mode block cipher encryption. Use CBC or GCM instead. However, beware the
[padding oracle attack](http://en.wikipedia.org/wiki/Padding_oracle_attack).
* Always use [initialization vectors](http://en.wikipedia.org/wiki/Initialization_vector)
in your block ciphers. It's good for you.
* Textbook RSA is insecure. Use RSA with [OAEP padding](http://en.wikipedia.org/wiki/Optimal_asymmetric_encryption_padding).
* Never implement your own crypto.

## A briefer summary of cryptography

Never implement your own crypto.

Unless it's for your own edification and you promise to never use it in
production.
