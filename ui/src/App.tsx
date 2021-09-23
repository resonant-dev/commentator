import { useEffect, useState } from 'preact/hooks';
import { Socket } from 'phoenix';

import Comment from './components/Comment';
import { apiFetch } from './utils/api';

const socket = new Socket('ws://localhost:4040/socket', { params: { userToken: '123' } });
socket.connect();

export const App = () => {
    const [comments, setComments] = useState([]);

    useEffect(() => {
        apiFetch({
            endpoint: 'comments',
        }).then(({ data }) => {
            setComments(data);
            const channel = socket.channel('site:mysite');
            channel.on('new_msg', (comment) => {
                console.log({ comment });
                setComments(comment.append(comment));
            });
            channel
                .join()
                .receive('ok', ({ messages }) => console.log('catching up', messages))
                .receive('error', ({ reason }) => console.log('failed join', reason))
                .receive('timeout', () => console.log('Networking issue. Still waiting...'));
        });
    }, []);

    return (
        <div>
            <ul role="list" className="divide-y divide-gray-200">
                {comments.map((comment: any) => (
                    <Comment comment={comment} />
                ))}
            </ul>
        </div>
    );
};
