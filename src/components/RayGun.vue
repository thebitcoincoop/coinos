<template>
<div class="center">
  <div class="center__image">
  <!-- svg --> 
  <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" id="background" width="800" height="600" viewBox="0 0 800 600">
    <defs>
      <clipPath id="clip-path">
        <path d="M489,194.27C345,169.72,288,261,288,300c0,40.49,57,130.08,201,105.53,5.43-.93,10.42-1.8,15-2.64V196.7C499.42,195.86,494.43,195.19,489,194.27Z" style="fill: none"/>
      </clipPath>
    </defs>
    <g class="artwork" id="artwork" data-name="artwork">
      <circle class="gun-charge" id="charging-circle" cx="568" cy="300" r="164" style="fill: #4193f2"/>
      <g id="beam">
        <line class="beam-blue" id="line-blue" x1="569" y1="300" x2="2000" y2="300" style="stroke-linecap: round; stroke: #4193f2;stroke-miterlimit: 10;stroke-width: 8px"/>
        <line class="beam-white" id="line-white" x1="569" y1="300" x2="2000" y2="300" style="stroke-linecap: round; stroke: #fff;stroke-miterlimit: 10;stroke-width: 8px"/>
      </g>
      <g class="raygun" id="raygun">
        <path class="gun-trigger" id="gun-trigger" d="M463.91,390.15a14,14,0,1,0-18.07,16.12C452.5,434.44,466,439.76,466,439.76l-7.34-35.62A14,14,0,0,0,463.91,390.15Z" style="fill: #86a4b7"/>
        <path id="handle-grip" d="M419,392s-17.61,46-9.75,84c0,0-23.3,1.33-29.26-19,0,0-2.17-43.33,19.51-67Z" style="fill: #86a4b7"/>
        <path id="handle" d="M358.21,391.64c10.73,7.56,29.79,27.68,10.27,67.4a2,2,0,0,0,.08,1.93c2.42,3.88,13,18,38.07,16.32a2,2,0,0,0,.68-3.83c-13.23-5.83-33.71-24.49-2-82.49a2,2,0,0,0-1.75-3H359.35A2,2,0,0,0,358.21,391.64Z" style="fill: #aa1f25"/>
        <path id="fin-background" d="M313.14,233.89l-31.65-47.7A4,4,0,0,1,282,180c14.71-10,61.33-24,139.76,8.16,3.87,1.59,2.4,7.55-1.79,7.57-23.91.07-68.2,5.2-101.26,38.11A4,4,0,0,1,313.14,233.89Z" style="fill: #cab02d"/>
        <g id="gun-tip">
          <polygon id="barrel" points="480 260 480 332 568 300 480 260" style="fill: #fddb00"/>
          <polygon id="barrel-shadow" points="480 300 480 332 568 300 480 300" style="fill: #cab02d"/>
          <circle id="tip" cx="568" cy="300" r="16" style="fill: #c72f3b"/>
          <circle id="tip--highlight" cx="568" cy="292" r="4" style="fill: #ef8c99"/>
        </g>
        <g id="gun-background">
          <path id="background-3" data-name="background" d="M489,194.27C345,169.72,288,261,288,300c0,40.49,57,130.08,201,105.53,5.43-.93,10.42-1.8,15-2.64V196.7C499.42,195.86,494.43,195.19,489,194.27Z" style="fill: #c72f3b"/>
          <rect id="background-shadow" x="472" y="340" width="8" height="48" rx="4" ry="4" style="fill: #aa1f25"/>
          <path d="M400,246.71a64,64,0,0,1,63.34,54.86,64,64,0,1,0-126.68,0A64,64,0,0,1,400,246.71Z" style="fill: #aa1f25"/>
          <path id="tailfin-shadow" d="M302.55,342.75C315.47,332.66,337,331,337,331l-10-16-34.62,7.21A106.37,106.37,0,0,0,302.55,342.75Z" style="fill: #aa1f25"/>
          <path d="M462.5,212.47l-6.32-.9c-2-.34-4.37-0.51-7.11-0.8s-5.85-.45-9.26-0.67c-1.7-.13-3.48-0.09-5.32-0.15l-2.81-.05c-1,0-1.91,0-2.89,0-2,.07-4,0-6,0.19s-4.15.24-6.28,0.43-4.29.43-6.48,0.69-4.39.62-6.61,1-4.45.79-6.67,1.28l-3.34.76-1.67.38-1.66.44c-2.21.59-4.43,1.16-6.61,1.86-1.09.34-2.19,0.66-3.27,1L377,219.09c-2.15.7-4.21,1.59-6.29,2.36s-4.07,1.69-6,2.59c-3.93,1.78-7.65,3.69-11.12,5.6s-6.67,3.88-9.54,5.82-5.47,3.78-7.7,5.5-4.12,3.3-5.65,4.64c-3,2.68-4.63,4.39-4.63,4.39s1.47-1.81,4.36-4.67c1.45-1.43,3.24-3.14,5.39-5s4.62-3.91,7.42-6,5.91-4.28,9.29-6.46,7-4.32,10.93-6.37c1.94-1,4-2,6-3s4.12-1.95,6.27-2.8l3.22-1.34c1.08-.43,2.18-0.83,3.28-1.24,2.18-.85,4.42-1.58,6.66-2.32l1.68-.56,1.69-.49,3.39-1c2.26-.65,4.54-1.16,6.79-1.74s4.53-1,6.76-1.43,4.47-.75,6.65-1.12,4.36-.56,6.48-0.84,4.2-.38,6.23-0.58c1-.08,2-0.19,3-0.23l2.92-.12c1.91-.06,3.76-0.21,5.54-0.18,3.56,0,6.8-.06,9.73.11s5.5,0.19,7.49.39l6.37,0.52a4.5,4.5,0,1,1-.73,9Z" style="fill: #ef8c99"/>
        </g>
        <g id="mask-shine">
          <g style="clip-path: url(#clip-path)">
            <polygon class="sheen" id="sheen" points="392 188 184 188 407 412 616 412 392 188" style="fill: #fff"/>
          </g>
        </g>
        <g id="gun-metal">
          <rect x="488" y="188" width="16" height="224" rx="4" ry="4" style="fill: #b0cce1"/>
          <circle cx="496" cy="196" r="4" style="fill: #fff"/>
          <circle cx="496" cy="403" r="4" style="fill: #86a4b7"/>
          <rect x="492" y="204" width="8" height="48" rx="4" ry="4" style="fill: #fff"/>
        </g>
        <g id="gun-detail">
          <path d="M400,224a76,76,0,0,0-69.77,45.85,4,4,0,0,0-1.67.26l-50.83,19.68a4,4,0,0,0-1.38,6.56l10,10a2,2,0,0,1-.21,3l-36.35,19A2,2,0,0,0,251,332h79a4,4,0,0,0,1-.14A76,76,0,1,0,400,224Zm0,140a64,64,0,1,1,64-64A64,64,0,0,1,400,364Z" style="fill: #fddb00"/>
          <path d="M327.17,324H292a2,2,0,0,1-.85-3.81L324,306.12a2,2,0,0,1,2.72,1.11L329,321.3A2,2,0,0,1,327.17,324Z" style="fill: #cab02d"/>
          <g id="lightning-bolt">
            <path d="M402,349.53a3.48,3.48,0,0,1-3.52-3.5V314a0.5,0.5,0,0,0-.5-0.5H375a3.5,3.5,0,0,1-3.24-4.83l23-55.89a3.43,3.43,0,0,1,3.21-2.17,3.48,3.48,0,0,1,3.52,3.5V286a0.5,0.5,0,0,0,.5.5h23a3.5,3.5,0,0,1,3.23,4.85l-23,56a3.43,3.43,0,0,1-3.21,2.16h0Z" style="fill: #fff"/>
            <path d="M398,252.11a2,2,0,0,1,2,2V286a2,2,0,0,0,2,2h23a2,2,0,0,1,1.85,2.77l-23,56A1.93,1.93,0,0,1,402,348a2,2,0,0,1-2-2V314a2,2,0,0,0-2-2H375a2,2,0,0,1-1.85-2.76l23-55.89a1.93,1.93,0,0,1,1.83-1.24m0-3a4.9,4.9,0,0,0-4.6,3.1l-23,55.89A5,5,0,0,0,375,315h22v31a5,5,0,0,0,5,5,4.91,4.91,0,0,0,4.59-3.07l23-56A5,5,0,0,0,425,285H403V254.11a5,5,0,0,0-5-5h0Z" style="fill: #c72f3b"/>
          </g>
        </g>
        <g id="fin-foreground">
          <path d="M310.55,249.89l-34.59-33a2.91,2.91,0,0,1-.33-4.26c9.48-10.19,52.08-51.09,133.51-18.22a2.93,2.93,0,0,1-.6,5.63c-20.58,3.55-67.87,13.33-93.84,49.49A2.92,2.92,0,0,1,310.55,249.89Z" style="fill: #fddb00"/>
          <path d="M383,197s-6.06-1-15.21-1.44c-4.57-.24-9.92-0.34-15.62-0.13-2.85.09-5.79,0.3-8.77,0.56s-6,.65-9,1.15c-1.49.25-3,.5-4.45,0.82l-2.2.46-2.16.53c-2.87.7-5.64,1.58-8.28,2.5-1.31.47-2.58,1-3.83,1.49L310,204.59l-3.24,1.75-2.9,1.81L301.3,210c-0.81.57-1.48,1.23-2.16,1.79l-1,.83c-0.3.28-.57,0.57-0.84,0.84l-1.46,1.47c-0.85.92-1.44,1.7-1.88,2.21l-0.66.78-0.16.2a3,3,0,1,1-4.6-3.86l0.11-.13,0.81-.86c0.54-.55,1.27-1.4,2.3-2.39l1.76-1.57c0.32-.28.65-0.59,1-0.88l1.14-.86c0.8-.58,1.6-1.26,2.54-1.84s1.9-1.22,2.92-1.85l3.29-1.78,3.61-1.67,3.9-1.52c1.35-.43,2.72-0.92,4.14-1.33,2.83-.8,5.77-1.54,8.79-2.08l2.27-.41,2.29-.34c1.53-.24,3.07-0.4,4.61-0.56,3.08-.32,6.17-0.5,9.21-0.61s6-.11,8.91,0c5.77,0.14,11.13.57,15.7,1.09C377,195.66,383,197,383,197Z" style="fill: #ccb32c"/>
        </g>
      </g>
      <g id="shockwave">
        <line class="line" id="line-8" x1="568" y1="300" x2="568" y2="156" style="fill: none;stroke: #fff;stroke-linecap: round;stroke-miterlimit: 10;stroke-width: 8px"/>
        <line class="line" id="line-7" x1="568" y1="300" x2="669.82" y2="198.18" style="fill: none;stroke: #fff;stroke-linecap: round;stroke-miterlimit: 10;stroke-width: 8px"/>
        <line class="line" id="line-6" x1="568" y1="300" x2="712" y2="300" style="fill: none;stroke: #fff;stroke-linecap: round;stroke-miterlimit: 10;stroke-width: 8px"/>
        <line class="line" id="line-5" x1="568" y1="300" x2="669.82" y2="401.82" style="fill: none;stroke: #fff;stroke-linecap: round;stroke-miterlimit: 10;stroke-width: 8px"/>
        <line class="line" id="line-4" x1="568" y1="300" x2="568" y2="444" style="fill: none;stroke: #fff;stroke-linecap: round;stroke-miterlimit: 10;stroke-width: 8px"/>
        <line class="line" id="line-3" x1="568" y1="300" x2="466.18" y2="401.82" style="fill: none;stroke: #fff;stroke-linecap: round;stroke-miterlimit: 10;stroke-width: 8px"/>
        <line class="line" id="line-2" x1="568" y1="300" x2="424" y2="300" style="fill: none;stroke: #fff;stroke-linecap: round;stroke-miterlimit: 10;stroke-width: 8px"/>
        <line class="line" id="line-1" x1="568" y1="300" x2="466.18" y2="198.18" style="fill: none;stroke: #fff;stroke-linecap: round;stroke-miterlimit: 10;stroke-width: 8px"/>
      </g>
    </g>
  </svg>
  </div>
  <div class="center__plug">
    <p>Extra: I wrote a <a href="#">blog post</a> explaning my process for creating this animation.</p>
  </div>
</div>
</template>

<style scoped>
// animation duration controls the length of the entire animation
$animation-duration: 4000ms;

//-- Lets get started!

//-
// The artwork layer controls the vertical movement and scale of the entire animation
.artwork {
  transform-origin: 0;
  animation: artwork $animation-duration ease-in-out infinite;
}
@keyframes artwork {
  000% {
    transform: translateY(800px);
  }
  015% {
    transform: translateY(0);
  }
  020% {
    transform: translateY(0);
  }
  050% {
    transform: scale(1) translateX(0);
  }
  052% {
    transform: scale(0.6) translate(0, -120px);
  }
  060% {
    transform: scale(0.6) translate(80px, -140px);
  }
  070% {
    transform: scale(0.6) translate(80px, -120px);
  }
  080%,
  100% {
    transform: scale(0.6) translate(80px, -800px)
  }
}

//-
// The raygun layer controls the rotation and bouncing of the gun
.raygun {
  transform-origin: center;
  animation: raygun $animation-duration ease-in-out infinite;
}
@keyframes raygun {
  000% {
    transform: rotate(40deg);
  }
  015% {
    transform: rotate(-16deg);
  }
  025% {
    transform: rotate(8deg);
  }
  030% {
    transform: rotate(-2deg);
  }
  //--- chargin
  032%,
  036%,
  040%,
  044%,
  048% {
    transform: rotate(-0.5deg);
  }
  034%,
  038%,
  042%,
  046%,
  050% {
    transform: rotate(0.5deg);
  }
  //--- mah lazor
  050% {
    transform: rotate(0);
  }
  052% {
    transform: rotate(-16deg);
  }
  060% {
    transform: rotate(12deg);
  }
  080%,
  100% {
    transform: rotate(-12deg);
  }
}

//-
// Gun trigger
.gun-trigger {
  transform-origin: center 20%;
  animation: gun-trigger $animation-duration ease-in-out infinite;
}
@keyframes gun-trigger {
  000%,
  030%{
    transform: rotate(0);
  }
  046% {
    transform: rotate(32deg);
  }
  048%,
  100% {
    transform: rotate(0);
  }
}

//-
// White polygon that travels across the gun, Masked
.sheen {
  animation: sheen $animation-duration ease-in-out infinite;
}
@keyframes sheen {
  000%,
  025% {
    transform: translateX(-320px);
  }
  040%,
  055% {
    transform: translateX(320px);
  }
  070%,
  100% {
    transform: translateX(-320px);
  }
}

//-
// Gun charging circle
.gun-charge {
  transform-origin: center;
  animation: gun-charge $animation-duration ease-in-out infinite;
}
@keyframes gun-charge{
  000%,
  025% {
    opacity: 0;
    fill: #4193f2;
    transform: scale(1);
  }
  045% {
    opacity: 0.5;
    fill: #4193f2;
    transform: scale(0.9);
  }
  050%,
  100% {
    opacity: 1;
    fill: white;
    transform: scale(0);
  }
}


//-
// Little shockwave particle things, reused stroke animation on each line.
.line {
  animation: fire $animation-duration ease-in-out infinite;
}
@keyframes fire {
  0%,
  049% {
    stroke: transparent;
    stroke-dashoffset: 0;
    stroke-dasharray: 5,200;
  }
  050% {
    stroke: white;
  }
  055% {
    stroke-dashoffset: -80px;
    stroke-dasharray: 20,200;
    stroke: white;
  }
  060%,
  100% {
    stroke-dashoffset: -120px;
    stroke-dasharray: 5,200;
    stroke: transparent;
  }
}


//-
// Firing beam stroke animations
.beam-white {
  animation: white-beam $animation-duration ease-in-out infinite;
}
@keyframes white-beam {
  000%,
  050% {
    opacity: 0;
    stroke-dashoffset: 0;
    stroke-dasharray: 400,2000;
  }
  051%,
  069% {
   opacity: 1;
  }
  070%,
  100% {
    opacity: 0;
    stroke-dashoffset: -500px;
    stroke-dasharray: 0,2000;
  }
}

.beam-blue {
  animation: blue-beam $animation-duration ease-in-out infinite;
}
@keyframes blue-beam {
  000%,
  055% {
    opacity: 0;
    stroke-dashoffset: 0;
    stroke-dasharray: 300,2000;
  }
  056%,
  069% {
   opacity: 1;
  }
  070%,
  100% {
    opacity: 0;
    stroke-dashoffset: -550px;
    stroke-dasharray: 0,2000;
  }
}


//--- Making the display look pretty
//-- Display / Setup
html {
  width: 100%;
  height: 100%;
}
body {
  background: #303845;
  display: flex;
  align-items: center;
  justify-content: center;
  width: 100%;
  height: 100%;
  padding: 24px;
  box-sizing: border-box;
}
svg {
  display: block;
  max-width: 100%;
  height: auto;
}
.center {
  position: relative;
  &:before {
    content: 'SVG + CSS';
    display: none;
    position: absolute;
    bottom: 16px;
    left: 16px;
    padding: 8px 12px;
    font-weight: bold;
    font-size: 14px;
    color: white;
    background: #7f8794;
    border-radius: 4px;
    font-family: arial, helvetica, sans-serif;
    box-shadow: 0 3px 0 black;
  }
}

@media screen and (max-width: 480px) {
  .center:before {
    display: none;
  }      
}

.center__image {
  background: #1c232d;
}
.center__plug {
  display:none;
  font-family: arial, helvetica, sans-serif;
  width: 100%;
  margin-top: 64px;
  text-align: center;
  color: #9ca3af;
  a {
    color: #4193f2;
  }
}
</style>
