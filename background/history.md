{% extends "base.md" %}

{% block article %}

# History

## Caesar cipher

The [Caesar cipher](http://en.wikipedia.org/wiki/Caesar_cipher) is one of the
simplest cryptosystems. To encrypt a message, we apply a constant shift to each
character. To decrypt a ciphertext, we apply the opposite shift to each
character.

```
k = 3
plain:  a b c d ... z
cipher: d e f g ... c
```

To formalize this, we generate the secret key $$k$$ by choosing a random natural
number in the range from 1 to 26 (inclusive). This can be otherwise written as
$$k \in \{1..26\}$$. For the $$i$$th character, encryption is defined as
$$c_i = Enc_k(m_i) = m_i + k$$, and decryption is defined as
$$m_i = Dec_k(c_i) = c_i - k$$.

### Cryptanalysis

The *cryptanalysis* of a cryptosystem is the analysis of a cryptosystem to
discover hidden properties about it, most often to break its security. The
cryptanalysis of the Caesar cipher is very straightforward. Because the size of
our search space is fairly small (26 if limited to the English alphabet), we
can trivially brute force every possible key (constant shift) and see which one
results in a non-gibberish message.

## Intermission

It is a good idea at this point to introduce [Kerckhoff's
principle](http://en.wikipedia.org/wiki/Kerckhoffs%27s_principle). In contrast
to the principle of security through obscurity, it should be okay for an
encryption scheme to be public knowledge, as long as the key remains a secret.
A modern interpretation of this principle is that cryptographic algorithms
should be public, standardized, and scrutinized in public.

For our Caesar cipher, security of the scheme relies on the adversary not
knowing how a message is encrypted.

Another key idea to introduce at this point is the "sufficient key space
principle", which states that any secure encryption scheme should not be
vulnerable to an exhaustive search over key space. Note that, while this is
a necessary property for a cryptosystem, it is not sufficient for security.

Once an adversary knows that a message is encrypted with a Caesar cipher, all
he or she has to do is to enumerate every possible key and try them all to
decrypt the message. Since the key space is not very large, it takes a very
short amount of time to break the cipher.

So, why do we even discuss such trivially broken ciphers? Not only do they
serve as a foundation for our discussion but also that they are surprisingly
still in use today. In 2006, the Mafia boss Bernardo Provenzano was captured
after the police intercepted messages written in an easily cracked code (which
used a Caesar cipher!) between him and other Mafia members.[^provenzano] In
2011, authorities were able to stop Rajib Karim from blowing up British Airways
planes because he relied on a Caesar cipher to communicated with an al-Qaeda
leader. He rejected using modern cryptography because "non-believers know about
it so it must be less secure".[^karim]

[^provenzano]: [Language Log: The Provenzano Code](http://itre.cis.upenn.edu/myl/languagelog/archives/003049.html)
[^karim]: [BA jihadist relied on Jesus-era encryption](http://www.theregister.co.uk/2011/03/22/ba_jihadist_trial_sentencing/)

## Mono-alphabetic cipher

A simple improvement to the Caesar cipher that significantly (on a relative
scale) improves its security is to not use a constant shift but to freely map
each letter in the alphabet to a different letter in the alphabet. This is
commonly used in the [cryptography
puzzles](http://en.wikipedia.org/wiki/Cryptogram) you find in newspapers.

```
plain:  a b c d ...
cipher: X E U A ...
```

This change increases the key space, assuming our 26-letter English alphabet,
from 26 to $$26!$$, which is approximately $$2^{88}$$. (Note that the key space is
not $$26^{26}$$ because we have to ensure that multiple plaintext letters do not
map to the same letter in ciphertext. To make this further clear, imagine that
we have a two-letter alphabet with *a* and *b*. If we map plaintext *a* to
ciphertext *b*, then we have no choice but to map plaintext *b* to ciphertext
*a*. Otherwise, we will have trouble decrypting the ciphertext.)

### Cryptanalysis

To solve a cryptogram, one normally looks for the letters that appear the most
common and surmises that these letters must correspond to letters that most
commonly appear in English text. Cryptanalysis of a mono-alphabetic cipher is
similar to the method one would employ to solve a cryptogram: [frequency
analysis](http://en.wikipedia.org/wiki/Frequency_analysis) of characters in the
ciphertext.

## Vigenère cipher

An improvement to the mono-alphabetic cipher is the poly-alphabetic shift
cipher known as the [Vigenère
cipher](http://en.wikipedia.org/wiki/Vigen%C3%A8re_cipher). This cipher was
invented in 1553 by Giovanni Battista Bellaso, but is often attributed to
French diplomat Blaise de Vigenère.

In this cryptosystem, we pick a key of some length, encode a length of
plaintext with it, and then repeat the process for the next length of
plaintext. This is illustrated below:

```
k = run
plain:  TOBEORNOTTOBE
key:    runrunrunrunr
cipher: KIOVIEEIGKIOV
```

### Cryptanalysis

This cipher remain unbroken for a long time because it circumvents naïve
frequency analysis. Let's see how one would perform cryptanalysis of this
scheme.

<!-- TODO: I probably don't know what I'm talking about here -->

Suppose we know the length of the key, $$n$$. We break the cipher text into
chunks of length $$n$$. For each chunk, we can solve it as a Caesar cipher.

In 1863, Friedrich Kasiski published a method to find $$n$$. The essence of the
method is to observe that repeated strings in the plaintext are eventually
encrypted in the same way because of the repeating nature of the key. If we
find such a repeating sequence in the ciphertext then we know that the key
length is likely a multiple of $$n$$.

What if we used a key the length of the message? We now have the one-time pad.

{% endblock %}
