$$
\newcommand\given[1][]{\:#1\vert\:}
$$

# Background

For context on modern cryptography, we start with some historical background
on cryptography. But first, some notation.

## Some notation

Here we start with some basic syntax that we will use throughout this site.
Alice wants to send a message to Bob.

* $m$: The plaintext, unencrypted message
* $k$: The secret key that both Alice and Bob have agreed to use to encrypt and
  decrypt the messages they exchange.
* $c$: The encrypted message, or ciphertext.
* $c = Enc_k(m)$: The encryption function that encrypts plaintext $m$ with
  secret key $k$ to produce ciphertext $c$.
* $m = Dec_k(c)$: The decryption function that decrypts ciphertext $c$ with
  secret key $k$ to produce plaintext $m$.

<!-- TODO diagram -->

A *cryptosystem* is defined by its $Enc_k(\cdot)$ and $Dec_k(\cdot)$ functions.
It is also defined by its $Gen$ function, which defines how keys are generated.
The correctness property of a cryptosystem is satisfied if
$Dec_k(Enc_k(m)) = m$.

## History

### Caesar cipher

The [Caesar cipher](http://en.wikipedia.org/wiki/Caesar_cipher) is one of the
simplest cryptosystems. To encrypt a message, we apply a constant shift to each
character. To decrypt a ciphertext, we apply the opposite shift to each
character.

```
k = 3
plain:  a b c d ... z
cipher: d e f g ... c
```

To formalize this, we generate the secret key $k$ by choosing a random natural
number in the range from 1 to 26 (inclusive). This can be otherwise written as
$k \in \{1..26\}$. For the $i$th character, encryption is defined as
$c_i = Enc_k(m_i) = m_i + k$, and decryption is defined as
$m_i = Dec_k(c_i) = c_i - k$.

#### Cryptanalysis

The *cryptanalysis* of a cryptosystem is the analysis of a cryptosystem to
discover hidden properties about it, most often to break its security. The
cryptanalysis of the Caesar cipher is very straightforward. Because the size of
our search space is fairly small (26 if limited to the English alphabet), we
can trivially brute force every possible key (constant shift) and see which one
results in a non-gibberish message.

### Intermission

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

### Mono-alphabetic cipher

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
from 26 to $26!$, which is approximately $2^{88}$. (Note that the key space is
not $26^{26}$ because we have to ensure that multiple plaintext letters do not
map to the same letter in ciphertext. To make this further clear, imagine that
we have a two-letter alphabet with *a* and *b*. If we map plaintext *a* to
ciphertext *b*, then we have no choice but to map plaintext *b* to ciphertext
*a*. Otherwise, we will have trouble decrypting the ciphertext.)

#### Cryptanalysis

To solve a cryptogram, one normally looks for the letters that appear the most
common and surmises that these letters must correspond to letters that most
commonly appear in English text. Cryptanalysis of a mono-alphabetic cipher is
similar to the method one would employ to solve a cryptogram: [frequency
analysis](http://en.wikipedia.org/wiki/Frequency_analysis) of characters in the
ciphertext.

### Vigenère cipher

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

#### Cryptanalysis

This cipher remain unbroken for a long time because it circumvents naïve
frequency analysis. Let's see how one would perform cryptanalysis of this
scheme.

<!-- TODO: I probably don't know what I'm talking about here -->

Suppose we know the length of the key, $n$. We break the cipher text into
chunks of length $n$. For each chunk, we can solve it as a Caesar cipher.

In 1863, Friedrich Kasiski published a method to find $n$. The essence of the
method is to observe that repeated strings in the plaintext are eventually
encrypted in the same way because of the repeating nature of the key. If we
find such a repeating sequence in the ciphertext then we know that the key
length is likely a multiple of $n$.

What if we used a key the length of the message? We now have the one-time pad.

## One-time pad

The one-time pad (OTP) is an encryption scheme that takes a key that is the
length of the message and XORs (bitwise exclusive-or) it with the message to
produce the ciphertext.

We will introduce some notation that we will be using from here on:

* $a \in_R A$: An element $a$ picked randomly from the set $A$.
* $\oplus$: [XOR](http://en.wikipedia.org/wiki/Exclusive_or)

For a quick refresher on some important properties of the bitwise XOR:

* $a \oplus b = b \oplus a$
* $a \oplus (b \oplus c) = (a \oplus b) \oplus c$
* $a \oplus a = 0$
* $a \oplus 0 = a$
* $a \oplus 1 = \neg a$
* $a \oplus b \oplus a = a \oplus a \oplus b = b$

The OTP cryptosystem is defined as thus. Given a binary message of length $n$
($m \in \{0, 1\}^n$):

* Key generation ($Gen$): $k \in_R \{0, 1\}^n$
* Encryption ($Enc$): $Enc_k(m) = k \oplus m = c$
* Decryption ($Dec$): $Dec_k(c) = c \oplus k = m$

### Security

Is the one-time pad "secure"? For that matter, what does "secure" even mean? It
could have several combination of these meanings:

* No adversary can compute secret key from ciphertext
* No adversary can compute plaintext from ciphertext
* No adversary can determine a character of plaintext
* No adversary can compute any meaningful information
* No adversary can compute an function of plaintext from ciphertext

#### Perfect secrecy

To formalize "security", we begin by defining properties that we want our
encryption scheme to have. One property that we want our scheme to have is
"perfect secrecy", which we will define as follows. Say we have a ciphertext
and we decrypt it to some plaintext message. The probability that this
ciphertext decrypts to this specific message is equal to the probability that
it decrypts to something else.

Some notation first:
* $M$: [Random variable](http://en.wikipedia.org/wiki/Random_variable)
  representing the space of plaintext messages
* $C$: Random variable representing the space of ciphertext messages
* $Pr[\cdot]$: The probability of an event

Formally, for every probability distribution over $\{m\}$ (the set of all
messages):

$$ \forall m \in \{m\}, \forall c \in \{c\}, \,
Pr[M = m \given C = c] = Pr[M = m]$$

Or equivalently...

$$Pr[C = c \given M = m] = Pr[C = c]$$

If you know your way around probability, you might recognize that this is
statistical independence:

$$ P(A \cap B) = P(A)P(B) \Leftrightarrow P(A \given B) = P(A)
\Leftrightarrow P(B \given A) = P(B)$$

**Lemma**: We also want our encryption scheme to have the property of *perfect
indistinguishability*. This basically means that ciphertext output by our
encryption scheme is indistinguishable from random noise. This follows directly
from our definition of perfect secrecy.

Formally, for every probability distribution over $\{m\}$:

$$ \forall m_0, m_1 \in \{m\}, \forall c \in \{c\}, \,
Pr[C = c \given M = m_0] = Pr[C = c \given M = m_1]$$

<div class='proof'>
**Proof**: We first prove that perfect secrecy implies perfect
indistinguishability. Take two messages $m_0$ and $m_1$. Via our perfect
secrecy:

1. $Pr[C = c \given M = m_0] = P[C = c]$
2. $Pr[C = c \given M = m_1] = P[C = c]$

Therefore, $Pr[C = c \given M = m_0] = Pr[C = c \given M = m_1]$.

We now show that perfect indistinguishability implies perfect secrecy. Given
a probability distribution over $\{m\}$, and an arbitrary $m_0$ and $c$:

$$
\begin{align*}
Pr[C = c] &= \sum_m Pr[C = c \given M = m] \cdot Pr[M = m] \\
          &= \sum_m Pr[C = c \given M = m_0] \cdot Pr[M = m] \\
          &= Pr[C = c \given M = m_0] \cdot \sum_m Pr[M = m] \\
          &= Pr[C = c \given M = m_0] \cdot 1 \\
          &= Pr[C = c \given M = m_0]
\end{align*}
$$

$\square$
</div>

### OTP security

OTP is perfectly secret. This might not be immediately obvious (and we are
going to prove it), but some intuition might help. Say that you're given $c_i$
(the $i$th bit in the ciphertext $c$). You know that the corresponding $k_i$
could be either 0 or 1 with equal probability. Thus, you have a 50% chance of
guessing the plaintext $m_i$ correctly.

Let's extend this intuition to the entire message: you know that roughly 50% of
$k$ is 1s and the other 50% is 0s. Thus, this means that roughly 50% of the
plaintext has had its bits flipped and the other 50% of the bits not flipped.
While this initially sounds like you have the advantage, you have to guess
which 50% of the ciphertext bits were actually flipped. Thus, the probability
that you guess all of these bits correctly is $\frac{1}{2^l}$, where $l$ is the
length of the message.

More formally, here is our proof that OTP is perfectly secret.

<div class='proof'>
**Proof**: Given key $k$, message $m$, ciphertext $c$, and length of the
message/ciphertext $l$:

$$
\begin{align*}
Pr[C = c \given M = m] &= Pr[M \oplus k = c \given M = m] \\
                       &= Pr[m \oplus k = c] \\
                       &= Pr[k = c \oplus m] \\
                       &= \frac{1}{2^l}
\end{align*}
$$

For any $m_0$ and $m_1$:

$$Pr[C = c \given M = m_0] = \frac{1}{2^l} = Pr[C = c \given M = m_1]$$

$\square$
</div>

### Conclusion

In the above sections, we have shown that OTP is perfectly secret, which is
probably enough for our definition of perfect security. So, we are done.

...or are we...

As it turns out, OTP is incredibly impractical to use. One problem that must be
solved for a cryptosystem to be useful is key distribution; two parties that
desire to communicate must be able to agree on what key to use. OTP key
distribution is difficult; parties must agree on what keys to use before all
future communications in order to avoid communicating the key, unencrypted, in
the clear.

In addition, the length of the key must be at least the length of the message.
This forces both parties to limit their message lengths to the length of the
key. As a side note...

**Theorem**: $(Gen, Enc, Dec)$ be a perfectly secret encryption scheme. This
implies that $|K| \geq |M|$, where $K = \{k\}$ and $M = \{m\}$ (i.e. the
lengths of the keys are at least the lengths of the messages).

<!-- TODO: this might not be correct -->
<!--
<div class='proof'>
**Proof**: We prove this by the contrapositive: if $|K| < |M|$, then our
scheme is not perfectly secure.

Fix a uniform distribution over $M$.
Let $M(c) = \{m : m = Dec_k(c) \text{ for some } k \in K\}$.
If $|M(c)| \leq |k|$, then there must exist some $m' \in M$ such that
$m' \notin M(c)$. Thus, $Pr[M = m' \given C = c] = 0 \neq Pr[M = m']$.
$\square$
</div>
-->

And finally, OTP keys must not be reused to encrypt multiple messages. Doing so
will compromise the security of the messages and the key, as an attacker will
know that a key is correct if it reveals both messages correctly.
