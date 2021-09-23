import useResource from './hooks/useResource';
import Comment from './components/Comment';
import type { CommentType } from './types/comments';

export const App = () => {
    const { data, loading } = useResource<CommentType>({ endpoint: 'comments', channelRoom: 'site:mysite' });

    return (
        <div className="bg-white">
            <div>
                <h2 className="sr-only">Comments</h2>
                <div className="-my-10">
                    {loading && !data.length && <div>Loading...</div>}
                    {!!data.length &&
                        data.map((comment: CommentType, id) => <Comment first={id === 0} comment={comment} />)}
                </div>
            </div>
        </div>
    );
};
