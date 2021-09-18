type Comment = {
    id: string;
    text: string;
    user: {
        name: string;
        imageUrl: string;
    };
    time: string;
};

type Props = {
    comment: Comment;
};

const Comment = ({ comment: { id, text, user, time } }: Props) => {
    return (
        <li key={id} className="py-4">
            <div className="flex space-x-3">
                <img className="h-6 w-6 rounded-full" src={user.imageUrl} alt="" />
                <div className="flex-1 space-y-1">
                    <div className="flex items-center justify-between">
                        <h3 className="text-sm font-medium">{user.name}</h3>
                        <p className="text-sm text-gray-500">{time}</p>
                    </div>
                    <p className="text-sm text-gray-500">{text}</p>
                </div>
            </div>
        </li>
    );
};

export default Comment;
