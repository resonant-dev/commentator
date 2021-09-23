import socket from '../utils/socket';

const useChannel = (room: string) => {
    const channel = socket.channel(room, {});

    const { on: subscribe, push, leave } = channel;

    const join = () =>
        channel
            .join()
            .receive('ok', ({ messages }) => console.log('catching up', messages))
            .receive('error', ({ reason }) => console.log('failed join', reason))
            .receive('timeout', () => console.log('Networking issue. Still waiting...'));

    return {
        join,
        leave,
        subscribe,
        push,
    };
};

export default useChannel;
