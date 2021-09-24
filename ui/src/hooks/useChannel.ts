import { useState, useEffect } from 'preact/hooks';
import socket from '../utils/socket';

const useChannel = (room: string, subscriptions?: { event: string; cb(response?: any): void }[]) => {
    const [isJoined, setIsJoined] = useState(false);
    const channel = socket.channel(room, {});

    const push = (event: string, payload: any, timeout?: number) => channel.push(event, payload, timeout);
    const subscribe = (event: string, cb: (response?: any) => void) => {
        console.log('subscribing to...', event);
        channel.on(event, cb);
    };
    const unsubscribe = (event: string, ref?: number) => channel.off(event, ref);

    useEffect(() => {
        subscriptions?.forEach(({ event, cb }) => channel.on(event, cb));

        !isJoined &&
            channel
                .join()
                .receive('ok', ({ messages }) => {
                    console.log('catching up', messages);
                    setIsJoined(true);
                })
                .receive('error', ({ reason }) => {
                    console.log('failed join', reason);
                    setIsJoined(false);
                })
                .receive('timeout', () => {
                    console.log('Networking issue. Still waiting...');
                    setIsJoined(false);
                });
        return () => {
            channel.leave();
            setIsJoined(false);
        };
    }, []);

    return {
        subscribe,
        unsubscribe,
        push,
    };
};

export default useChannel;
