import useResource from './hooks/useResource';
import Comment from './components/Comment';
import type { CommentType } from './types/comments';
import CommentForm from './components/CommentForm';

export const App = () => {
    const { data, loading, postData } = useResource<CommentType>({
        endpoint: 'comments',
        channelRoom: 'site:mysite',
    });

    return (
        <div className="ct-bg-white ct-py-4 ct-px-2">
            <h2 className="ct-sr-only">Comments</h2>
            <div className="ct--my-4">
                {loading && !data.length && <div>Loading...</div>}
                {!!data.length &&
                    data.map((comment: CommentType, id) => <Comment first={id === 0} comment={comment} />)}
            </div>
            <div className="ct-border-t ct-border-gray-200 ct-mt-4 ct-flex-1 ct-py-4">
                <CommentForm onSubmit={postData} />
            </div>
        </div>
    );
};
