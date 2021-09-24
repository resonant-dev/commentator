import { render } from 'preact';
import { App } from './App';
import './index.css';

// const shadowTarget = document.getElementById('commentator')!;
// const shadow = shadowTarget.attachShadow({ mode: 'closed' });
// const shadowRoot = document.createElement('div');
// shadowRoot.id = 'shadow-root';

// shadow.appendChild(shadowRoot);

// // Apply external styles to the shadow dom
// const linkElem = document.createElement('link');
// linkElem.setAttribute('rel', 'stylesheet');
// linkElem.setAttribute('href', './index.css');

// // Attach the created element to the shadow dom
// shadowRoot.appendChild(linkElem);

// render(<App />, shadowRoot);
render(<App />, document.getElementById('commentator')!);
