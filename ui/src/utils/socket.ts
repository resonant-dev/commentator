import { Socket } from 'phoenix';

const socket = new Socket('ws://localhost:4040/socket', { params: { userToken: '123' } });
socket.connect();

export default socket;
