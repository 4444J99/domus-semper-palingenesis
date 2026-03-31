# SuperCollider Pitfalls (Brahma Meta-Rack)

## Compile-Time Errors

### var-after-statement
All `var` declarations must appear at the TOP of each `{ }` block, before any statements.
```supercollider
// BAD:
{ |self| self.doSomething; var x = 5; }
// GOOD:
{ |self| var x; self.doSomething; x = 5; }
```

### `==` on UGens returns boolean, not BinaryOpUGen
SC's `==` does identity comparison. Use arithmetic instead.
```supercollider
// BAD: (mode == 3) → returns true/false, not a UGen
// GOOD: ((mode - 3).abs < 0.5)
// GOOD for ==0: (mode < 0.5)
```

### `if(UGen)` in SynthDefs
`if()` requires boolean. UGen comparisons return BinaryOpUGen.
```supercollider
// BAD: if(sidechainBus >= 0, { In.ar(sidechainBus, 1) }, { input })
// GOOD: Select.ar((sidechainBus >= 0), [input, In.ar(sidechainBus.clip(0, 2047), 1)])
```

### `Select.ar` requires audio-rate inputs
All array elements must be audio rate.
```supercollider
// BAD: Select.ar(idx, [sig1, 0, sig2])
// GOOD: Select.ar(idx, [sig1, DC.ar(0), sig2])
// BAD: Select.ar(idx, [sig1, controlRateArg])
// GOOD: Select.ar(idx, [sig1, K2A.ar(controlRateArg)])
```

### `Mix.fill` needs compile-time integer
First arg can't be a UGen.
```supercollider
// BAD: Mix.fill(voices.clip(1, 6), { ... })
// GOOD: Mix.fill(4, { |i| ... * (i < voices) })
```

### `Env` releaseNode/loopNode need compile-time integers
Can't use UGen args for loop/release nodes.

### `|>` pipe operator doesn't exist in SC
Nest function calls directly.

### `BufRd.ar` needs audio-rate phase
Wrap control-rate phase with `K2A.ar()`.

## sc3-plugins Fallbacks
- `PV_Freeze` → `PV_MagSmear(chain, (freeze * 100).round)`
- `FFTFlux.kr` → `(Slope.kr(Amplitude.kr(input, 0.01, 0.1)).abs * 10).clip(0, 1)`

## Runtime Gotchas

### Event method name collisions
SC's `Object` class defines `next`, `value`, `key`, etc. Event's `doesNotUnderstand`
mechanism only fires for methods NOT in the class hierarchy.
```supercollider
// BAD: markov.next → calls Object:next, returns the Event itself
// GOOD: markov[\next].(markov) → explicitly calls the stored function
```

### `.sum` on single-channel UGen
`.sum` is a Collection method. Single UGens don't respond to it.
```supercollider
// BAD: singleChannelSig.abs.sum
// GOOD: singleChannelSig.abs
```

### `LorenzL.ar` returns single channel
Not multi-output. Don't destructure with `#x, y, z = LorenzL.ar(...)`.
