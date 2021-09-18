import { uuidv4 } from './utils';

import Comment from './components/Comment';

const comments = [
    {
        id: uuidv4(),
        text: 'Great commment about a great post',
        user: {
            name: 'My Name',
            imageUrl:
                'https://images.unsplash.com/photo-1517841905240-472988babdf9?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=facearea&facepad=3&w=256&h=256&q=80',
        },
        time: 'time',
    },
    {
        id: uuidv4(),
        text: 'Another commment about a great post',
        user: {
            name: 'My Name',
            imageUrl:
                'https://images.unsplash.com/photo-1517841905240-472988babdf9?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=facearea&facepad=3&w=256&h=256&q=80',
        },
        time: 'time',
    },
];

export const App = () => {
    return (
        <div>
            <ul role="list" className="divide-y divide-gray-200">
                {comments.map((comment) => (
                    <Comment comment={comment} />
                ))}
            </ul>
        </div>
    );
};
